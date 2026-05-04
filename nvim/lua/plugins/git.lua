return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen origin/develop...HEAD<cr>', desc = 'Diff vs develop' },
      { '<leader>gp', function()
          local parent = vim.fn.system("git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null"):gsub('\n', '')
          if parent == '' or parent:match('fatal') then
            parent = 'origin/develop'
          end
          vim.cmd('DiffviewOpen ' .. parent .. '...HEAD')
        end, desc = 'Diff vs parent branch' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>',              desc = 'File history (current file)' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>',                desc = 'File history (branch)' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>',                      desc = 'Close diffview' },
    },
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn         = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text     = true,
        virt_text_pos = 'eol',
        delay         = 1000,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      max_file_length   = 40000,
      preview_config    = { border = 'single', style = 'minimal' },
    },
  },
}
