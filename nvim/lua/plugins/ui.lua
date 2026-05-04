return {
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      local cubensis = {
        normal = {
          a = { fg = '#000000', bg = '#00ffff', gui = 'bold' },
          b = { fg = '#8f9fb0', bg = '#1e2028' },
          c = { fg = '#8f9fb0', bg = '#13141a' },
        },
        insert = {
          a = { fg = '#000000', bg = '#2fcf17', gui = 'bold' },
          b = { fg = '#8f9fb0', bg = '#1e2028' },
          c = { fg = '#8f9fb0', bg = '#13141a' },
        },
        visual = {
          a = { fg = '#ffffff', bg = '#d6115d', gui = 'bold' },
          b = { fg = '#8f9fb0', bg = '#1e2028' },
          c = { fg = '#8f9fb0', bg = '#13141a' },
        },
        replace = {
          a = { fg = '#ffffff', bg = '#ff059f', gui = 'bold' },
          b = { fg = '#8f9fb0', bg = '#1e2028' },
          c = { fg = '#8f9fb0', bg = '#13141a' },
        },
        command = {
          a = { fg = '#000000', bg = '#a0b325', gui = 'bold' },
          b = { fg = '#8f9fb0', bg = '#1e2028' },
          c = { fg = '#8f9fb0', bg = '#13141a' },
        },
        inactive = {
          a = { fg = '#545a5e', bg = '#1e2028' },
          b = { fg = '#545a5e', bg = '#13141a' },
          c = { fg = '#545a5e', bg = '#13141a' },
        },
      }
      return {
      options = {
        icons_enabled      = true,
        theme              = cubensis,
        component_separators = { left = '', right = '' },
        section_separators   = { left = '', right = '' },
        globalstatus       = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', file_status = true, path = 2 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
      },
    }
    end,
  },

  {
    'rcarriga/nvim-notify',
    lazy     = false,
    priority = 900,
    opts = {
      render  = 'compact',
      stages  = 'fade',
      timeout = 3000,
    },
    config = function(_, opts)
      require('notify').setup(opts)
      vim.notify = require('notify')
    end,
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts  = {},
  },
}
