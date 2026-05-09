local lsp_setup = require("config/lsp_setup")
local language_servers = {
	"ts_ls",
	"jsonls",
	"cssls",
	"html",
	"emmylua_ls",
	"emmet_language_server",
	"omnisharp"
}

for _, language_server in ipairs(language_servers) do
	vim.lsp.config(language_server, {
		on_attach = lsp_setup.on_attach,
		capabilities = lsp_setup.capabilities
	})
end

vim.lsp.config('omnisharp', {
	settings = {
		FormattingOptions = {
			EnableEditorConfigSupport = true,
			OrganizeImports = nil,
		},
		MsBuild = {
			LoadProjectsOnDemand = nil,
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = nil,
			EnableImportCompletion = nil,
			AnalyzeOpenDocumentsOnly = nil,
		},
		Sdk = {
			IncludePrereleases = true,
		},
	}
})

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
