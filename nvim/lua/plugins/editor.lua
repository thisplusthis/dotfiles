return {
  -- Motion (replaces hop.nvim)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts  = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump()              end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter()        end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o',               function() require('flash').remote()            end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' },      function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    },
  },

  -- Surround (ys/cs/ds)
  {
    'kylechui/nvim-surround',
    version = '*',
    event   = 'VeryLazy',
    opts    = {},
  },

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup({
        check_ts         = true,
        disable_filetype = { 'TelescopePrompt', 'vim' },
        ts_config = {
          lua        = { 'string' },
          javascript = { 'template_string' },
          java       = false,
        },
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp           = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Keymap discoverability
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts  = {
      preset = 'helix',
      spec = {
        { '<leader>f', group = 'find' },
        { '<leader>x', group = 'trouble' },
        { '<leader>d', group = 'debug' },
        { '<leader>w', group = 'workspace' },
      },
    },
  },

  -- Diagnostics / LSP / quickfix UI
  {
    'folke/trouble.nvim',
    cmd  = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',                         desc = 'Diagnostics' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',            desc = 'Buffer diagnostics' },
      { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>',                 desc = 'Symbols' },
      { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',  desc = 'LSP refs/defs' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                             desc = 'Location list' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                              desc = 'Quickfix list' },
    },
    opts = {},
  },
}
