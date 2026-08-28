require 'nvim-treesitter'.setup {
	ensure_installed = { "lua", "c", "typescript", "json", "css", "html", "yaml" },

	sync_install = false,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true
	},
}
