local opt = vim.opt

-- UI
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.termguicolors  = true
opt.showmode       = false
opt.signcolumn     = 'yes'
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.splitbelow     = true
opt.splitright     = true
opt.mouse          = 'a'

-- Indentation
opt.autoindent = true
opt.expandtab  = true
opt.tabstop    = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Search
opt.incsearch  = true
opt.hlsearch   = false
opt.ignorecase = true
opt.smartcase  = true

-- Completion
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- System clipboard
opt.clipboard = 'unnamedplus'

-- Persistent undo
opt.undofile  = true
opt.undolevels = 10000

-- Disable netrw (nvim-tree / oil replace it)
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.colorcolumn = '121'
  end,
})
