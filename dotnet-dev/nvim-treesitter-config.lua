require 'nvim-treesitter'.setup {
	ensure_installed = { "typescript", "json", "css", "html", "lua", "yaml", "c_sharp", "bicep" },

	sync_install = false,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true
	},
}
