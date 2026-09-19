local parser_dir = vim.fn.stdpath('data') .. '/site'
vim.opt.runtimepath:prepend(parser_dir)

require('nvim-treesitter').setup {
	install_dir = parser_dir
}

require('nvim-treesitter').install { 'typescript', 'json', 'css', 'html', 'lua', 'yaml', 'php' }
