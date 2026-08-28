local lsp_setup = {}

lsp_setup.on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, opts)
	vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.display, opts)
	vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, opts)

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
		callback = function()
			vim.lsp.buf.format()
		end
	})

	-- Omnisharp Extended support
	if vim.bo.filetype == "cs" then
		vim.keymap.set("n", "gd", function()
			require("omnisharp_extended").lsp_definition()
		end, opts)

		vim.keymap.set("n", "gr", function()
			require("omnisharp_extended").lsp_references()
		end, opts)

		vim.keymap.set("n", "gI", function()
			require("omnisharp_extended").lsp_implementation()
		end, opts)

		vim.keymap.set("n", "gy", function()
			require("omnisharp_extended").lsp_type_definition()
		end, opts)
	end
end

lsp_setup.capabilities = require('cmp_nvim_lsp').default_capabilities()

return lsp_setup
