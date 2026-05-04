local M = {}

function M.on_attach(_, bufnr)
  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  map('n', 'gD',         vim.lsp.buf.declaration,     'Declaration')
  map('n', 'gd',         vim.lsp.buf.definition,      'Definition')
  map('n', 'gi',         vim.lsp.buf.implementation,  'Implementation')
  map('n', 'gr',         vim.lsp.buf.references,      'References')
  map('n', 'K',          vim.lsp.buf.hover,           'Hover')
  map('n', '<space>D',   vim.lsp.buf.type_definition, 'Type definition')
  map('n', '<space>rn',  vim.lsp.buf.rename,          'Rename')
  map('n', '<space>ca',  vim.lsp.buf.code_action,     'Code action')
  map('n', '<space>wa',  vim.lsp.buf.add_workspace_folder,    'Add workspace folder')
  map('n', '<space>wr',  vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
  map('n', '<space>wl',  function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List workspace folders')

  -- Signature help in insert mode (avoids <C-k> window-nav collision)
  map('i', '<C-s>', vim.lsp.buf.signature_help, 'Signature help')

  -- Format via conform
  map('n', '<space>f', function()
    require('conform').format({ async = true, lsp_fallback = true })
  end, 'Format buffer')
end

function M.capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    caps = cmp_nvim_lsp.default_capabilities(caps)
  end
  return caps
end

function M.servers()
  return {
    pyright = {},
    bashls  = {},
    lua_ls = {
      settings = {
        Lua = {
          runtime     = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace   = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry   = { enable = false },
        },
      },
    },
  }
end

return M
