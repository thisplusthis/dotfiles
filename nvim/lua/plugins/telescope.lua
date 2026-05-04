return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files()  end, desc = 'Find files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep()   end, desc = 'Live grep' },
      { '<leader>fb', function() require('telescope.builtin').buffers()     end, desc = 'Buffers' },
      { '<leader>fh', function() require('telescope.builtin').help_tags()   end, desc = 'Help tags' },
      { '<leader>fd', function() require('telescope.builtin').diagnostics() end, desc = 'Diagnostics' },
      { '<leader>fr', function() require('telescope.builtin').resume()      end, desc = 'Resume last picker' },
      { '<leader>fs', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'Document symbols' },
      { '<leader>fS', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, desc = 'Workspace symbols' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          path_display = { 'smart' },
        },
        extensions = {
          fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = 'smart_case',
          },
        },
      })
      telescope.load_extension('fzf')
    end,
  },
}
