local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

dap_virtual_text.setup();

mason_dap.setup({
	ensure_installed = { "delve" },
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end
	}
})

dap.adapters.go = {
	type = 'server',
	port = '${port}',
	executable = {
		command = vim.fn.exepath('dlv'),
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	},
}

dap.configurations.go = {
	{ type = "go", name = "Debug File", request = "launch", program = "${file}" },
}

ui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "B" })

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end
