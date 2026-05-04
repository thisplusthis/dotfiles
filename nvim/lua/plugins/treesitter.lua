return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false, -- plugin does not support lazy loading
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      -- Parsers are installed on-demand via :TSInstall <name>.
      -- Startup auto-install is omitted because parsers without pre-built binaries require
      -- tree-sitter-cli (run `cargo install tree-sitter-cli` first, then add an install()
      -- call here if you want auto-install on startup).

      -- Highlighting + folds; pcall skips filetypes with no parser (e.g. plugin UI buffers).
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.wo[0][0].foldmethod = 'expr'
            vim.wo[0][0].foldexpr  = 'v:lua.vim.treesitter.foldexpr()'
          end
        end,
      })
      vim.opt.foldenable = false

      require('treesitter-context').setup({ max_lines = 3 })

      -- Textobject select
      local select = require('nvim-treesitter-textobjects.select')
      vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer',    'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner',    'textobjects') end)

      -- Textobject move
      local move = require('nvim-treesitter-textobjects.move')
      vim.keymap.set('n', ']m', function() move.goto_next_start('@function.outer') end)
      vim.keymap.set('n', ']]', function() move.goto_next_start('@class.outer') end)
      vim.keymap.set('n', ']M', function() move.goto_next_end('@function.outer') end)
      vim.keymap.set('n', '][', function() move.goto_next_end('@class.outer') end)
      vim.keymap.set('n', '[m', function() move.goto_previous_start('@function.outer') end)
      vim.keymap.set('n', '[[', function() move.goto_previous_start('@class.outer') end)
      vim.keymap.set('n', '[M', function() move.goto_previous_end('@function.outer') end)
      vim.keymap.set('n', '[]', function() move.goto_previous_end('@class.outer') end)

      -- Textobject swap
      local swap = require('nvim-treesitter-textobjects.swap')
      vim.keymap.set('n', '<leader>>', function() swap.swap_next('@parameter.inner') end)
      vim.keymap.set('n', '<leader><', function() swap.swap_previous('@parameter.outer') end)
    end,
  },
}
