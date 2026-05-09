require 'nvim-treesitter'.setup {
	ensure_installed = { "typescript", "json", "css", "html", "lua", "yaml", "php" },

	sync_install = false,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true
	},
}
