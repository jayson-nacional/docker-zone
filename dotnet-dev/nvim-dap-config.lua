local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

dap_virtual_text.setup();

mason_dap.setup({
	ensure_installed = { "coreclr" },
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end
	}
})

dap.adapters.coreclr = {
	type = 'executable',
	command = vim.fn.exepath("netcoredbg"),
	args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	}
}

vim.g.dotnet_build_project = function()
	local cmd = "dotnet build -c Debug"
	print("Building project...")
	vim.fn.system(cmd)
end

table.insert(dap.configurations.cs, {
	type = "coreclr",
	name = "build & launch",
	request = "launch",
	program = function()
		vim.g.dotnet_build_project()
		return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net10.0/', 'file')
	end,
})

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
