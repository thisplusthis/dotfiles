-- Leader keys must be set before plugins load
vim.g.mapleader = ','
vim.g.maplocalleader = ','

require('config.options')
require('config.keymaps')
require('config.lazy')

-- Colorscheme (local file in colors/cubensis.vim)
pcall(vim.cmd.colorscheme, 'cubensis')
