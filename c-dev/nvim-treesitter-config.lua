require 'nvim-treesitter'.setup {
	ensure_installed = { "lua", "c" },

	sync_install = false,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true
	},
}
