local is_ok, toggleterm = pcall(require, 'toggleterm')
if not is_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<C-\>]], --  How to open a new terminal
    hide_numbers = true, -- hide the number column in toggleterm buffers
    direction = 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    shade_filetypes = {},
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'single',
        winblend = 0,
    },
})


-- define key mappints
--  t: terminal mode
function _G.set_terminal_keymaps()
    local opts = { noremap = true, buffer = 0 }
    -- Use <C-\> to toggle terminals when direction='float'
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    -- We can use <C-h/j/k/l> to move cursor among windows(including terminal window)
    -- If we set direction='float', these key mappings wont' helpful
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Toggleterm also exposes the `Terminal` class so that this can be used to create
-- custom terminals for showing terminal UIs like `lazygit`, `htop` etc.
local Terminal = require('toggleterm.terminal').Terminal

-- cmd = string -- command to execute when creating the terminal e.g. 'top'
local htop = Terminal:new({ cmd = 'htop', hidden = true })

function _HTOP_TOGGLE()
    htop:toggle()
end

-- docker / podman atlas container
local atlas_worker_container = Terminal:new({ cmd = 'podman exec -ti worker bash' })
local atlas_web_container = Terminal:new({ cmd = 'podman exec -ti atlas bash' })

function _atlas_web_container_toggle()
    atlas_web_container:toggle()
end

function _atlas_work_container_toggle()
    atlas_worker_container:toggle()
end

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua _atlas_web_container_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>z", "<cmd>lua _atlas_work_container_toggle()<CR>", {noremap = true, silent = true})

