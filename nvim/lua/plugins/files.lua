return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeOpen' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file tree' },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sort_by     = 'case_sensitive',
      view        = { width = 30, side = 'left' },
      renderer    = { group_empty = true },
      filters     = {
        -- dotfiles=false => show hidden/dot files by default (`H` toggles in tree)
        dotfiles = false,
        -- vim |regexp| on basename/relpath — keep .git/ out of the tree
        custom = { '^\\.git$' },
      },
      diagnostics = { enable = true },
    },
  },

  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory (oil)' },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      view_options = { show_hidden = true },
    },
  },
}
