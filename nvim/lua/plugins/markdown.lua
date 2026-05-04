return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- `none` = stock layout most README / tutorial setups use (full-width headings & code,
      -- sign column accents, checkbox icons). Tweaks below remap highlights to cubensis hues.
      preset = 'none',

      completions = {
        lsp = { enabled = true },
      },
      restart_highlighter = true,

      -- Default plugin links fenced code → ColorColumn (harsh magenta in cubensis).
      code = {
        highlight = 'CursorLine', -- bg #131726
        highlight_info = 'Function', -- cyan language label #3fc9e8
        highlight_inline = 'Comment', -- blue-grey #93a6cc / #2a303b
      },

      -- Heading bands: cool backgrounds + cyan → violet stripe (Cubensis specials).
      heading = {
        foregrounds = {
          'SpecialKey',
          'Function',
          'Directory',
          'Repeat',
          'PreProc',
          'Title',
        },
        backgrounds = {
          'Pmenu', -- slate band #2b303d
          'CursorLine',
          'Folded', -- deepest #10121a
          'CursorLine',
          'Pmenu',
          'Folded',
        },
      },
    },
  },
}
