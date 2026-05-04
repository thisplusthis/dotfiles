# Neovim Configuration

Modern Vim-like editor with LSP, Treesitter, and plugin management via lazy.nvim.

## Directory Structure

```
nvim/
├── init.lua              # Entry point, loads config modules
├── lazy-lock.json        # Lockfile for plugins (auto-generated)
├── .gitignore           # Tracks plugin/ directory
├── lua/
│   ├── config/          # Core configuration modules
│   │   ├── options.lua  # Vim settings (tabs, colors, etc.)
│   │   ├── keymaps.lua  # Custom keybindings
│   │   ├── lazy.lua     # lazy.nvim setup
│   │   └── lsp.lua      # LSP configuration
│   └── plugins/         # Individual plugin specifications
│       └── *.lua        # Each file = one or more plugins
├── plugin/              # (generated) Plugin runtime files — not tracked
├── colors/              # Custom color schemes
└── snippets/            # Snippet definitions (LuaSnip format)
```

## Setup

See [TOOLS.md](../TOOLS.md#editor-neovim) in the root for complete setup instructions:

1. Run `nvim` — lazy.nvim auto-installs plugins on first run (~30-60 seconds)
2. Inside Neovim, run `:Lazy`, `:TSUpdate`, `:Mason`, `:checkhealth`
3. Install language servers for your languages via `:Mason`

## Key Features

- **LSP** — Language servers for goto definition, rename, diagnostics, etc.
- **Treesitter** — Syntax highlighting and text objects
- **Telescope** — Fuzzy finding for files, buffers, grep
- **Completion** — nvim-cmp with smart autocomplete
- **Formatting** — conform.nvim integrates system formatters
- **Git** — gitsigns, fugitive, diffview for git workflows
- **Debugging** — DAP (Debug Adapter Protocol) support

## Plugin Configuration

Plugins are defined in `lua/plugins/*.lua`. Each file can contain one or more plugin specs using lazy.nvim format:

```lua
return {
  "author/plugin-name",
  config = function()
    -- Setup code
  end,
  keys = { /* keybindings */ },
  dependencies = { /* other plugins */ },
}
```

## Keybindings

Core bindings are in `lua/config/keymaps.lua`. See [TOOLS.md](../TOOLS.md#common-keybindings) for a complete reference.

**Common:**
- `Ctrl+h/j/k/l` — Navigate splits
- `gd` — Go to definition
- `,ff` — Find files (Telescope)
- `,ca` — Code action
- `gcc` — Toggle comment

## Customization

1. **Editor settings:** Edit `lua/config/options.lua`
2. **Keybindings:** Edit `lua/config/keymaps.lua`
3. **Add plugins:** Create a new file in `lua/plugins/` or edit existing ones
4. **Color scheme:** Set in `init.lua` (`:colorscheme` command)
5. **Snippets:** Add to `snippets/` directory

## Troubleshooting

**Plugins not installing:**
```vim
:Lazy sync
:Lazy update
```

**Treesitter not highlighting:**
```vim
:TSUpdate
:TSInstall <language>
```

**LSP not working:**
```vim
:LspInfo              " Show installed servers
:Mason                " Install language servers
:checkhealth lsp      " Diagnose LSP issues
```

**Colors look wrong:**
```vim
:set termguicolors    " Enable true color (should be in options.lua)
```

## Further Reading

- [lazy.nvim docs](https://github.com/folke/lazy.nvim)
- [Neovim docs](https://neovim.io/doc/)
- [LSP reference](https://microsoft.github.io/language-server-protocol/)
