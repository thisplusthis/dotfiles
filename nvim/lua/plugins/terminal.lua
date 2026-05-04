return {
  {
    'akinsho/toggleterm.nvim',
    cmd  = { 'ToggleTerm', 'TermExec' },
    keys = {
      { [[<C-\>]],   desc = 'Toggle terminal' },
      { '<leader>g', desc = 'Lazygit' },
      { '<leader>a', desc = 'Atlas web container' },
      { '<leader>z', desc = 'Atlas worker container' },
    },
    opts = {
      size          = 20,
      open_mapping  = [[<C-\>]],
      hide_numbers  = true,
      direction     = 'float',
      close_on_exit = true,
      shell         = vim.o.shell,
      float_opts    = { border = 'single', winblend = 0 },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new({
        cmd        = 'lazygit',
        dir        = 'git_dir',
        direction  = 'float',
        float_opts = { border = 'double' },
        on_open = function(term)
          vim.cmd('startinsert!')
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>',
            { noremap = true, silent = true })
        end,
      })
      local atlas_web    = Terminal:new({ cmd = 'podman exec -ti atlas bash' })
      local atlas_worker = Terminal:new({ cmd = 'podman exec -ti worker bash' })

      vim.keymap.set('n', '<leader>g', function() lazygit:toggle()      end,
        { noremap = true, silent = true, desc = 'Lazygit' })
      vim.keymap.set('n', '<leader>a', function() atlas_web:toggle()    end,
        { noremap = true, silent = true, desc = 'Atlas web container' })
      vim.keymap.set('n', '<leader>z', function() atlas_worker:toggle() end,
        { noremap = true, silent = true, desc = 'Atlas worker container' })

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*',
        callback = function()
          local o = { noremap = true, buffer = 0 }
          vim.keymap.set('t', '<esc>', [[<C-\><C-n>]],        o)
          vim.keymap.set('t', 'jk',    [[<C-\><C-n>]],        o)
          vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], o)
          vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], o)
          vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], o)
          vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], o)
        end,
      })
    end,
  },
}
