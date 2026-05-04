return {
  {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      log_level                  = 'error',
      auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
      auto_restore_enabled       = true,
      auto_save_enabled          = true,
    },
    init = function()
      vim.o.sessionoptions =
        'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    end,
  },
}
