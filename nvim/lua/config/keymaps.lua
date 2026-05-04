local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Resize splits
map('n', '<C-Up>',    ':resize -2<CR>',          opts)
map('n', '<C-Down>',  ':resize +2<CR>',          opts)
map('n', '<C-Left>',  ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Keep selection after indent
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Diagnostics (0.11+ API)
map('n', '<space>e', vim.diagnostic.open_float, opts)
map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
map('n', ']d', function() vim.diagnostic.jump({ count = 1,  float = true }) end, opts)
map('n', '<space>q', vim.diagnostic.setloclist, opts)
