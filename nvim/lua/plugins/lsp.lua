return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim',         config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      local lsp     = require('config.lsp')
      local servers = lsp.servers()

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = false,
      })

      require('mason-tool-installer').setup({
        ensure_installed = {
          'black',
          'isort',
          'ruff',
          'stylua',
          'shfmt',
          'shellcheck',
          'debugpy',
          'pyright',
          'bash-language-server',
        },
      })

      -- on_attach via autocmd (vim.lsp.config does not accept on_attach directly)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          lsp.on_attach(nil, ev.buf)
        end,
      })

      -- Global capabilities for all servers
      vim.lsp.config('*', { capabilities = lsp.capabilities() })

      -- Server-specific config (e.g. lua_ls settings)
      for name, cfg in pairs(servers) do
        if next(cfg) ~= nil then
          vim.lsp.config(name, cfg)
        end
      end

      -- Enable all servers (nvim-lspconfig ships lsp/*.lua definitions)
      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },
}
