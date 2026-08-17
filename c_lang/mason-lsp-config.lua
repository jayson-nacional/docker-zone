local lsp_setup = require("config/lsp_setup")
local language_servers = {
	"emmylua_ls",
	"clangd"
}

for _, language_server in ipairs(language_servers) do
	vim.lsp.config(language_server, {
		on_attach = lsp_setup.on_attach,
		capabilities = lsp_setup.capabilities
	})
end

vim.lsp.config('emmylua_ls', {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {
					'vim',
					'require',
				},
			},
		},
	},
})

require("mason-lspconfig").setup {
	ensure_installed = language_servers,
}
