# Dotfiles

Modern shell, editor, and git configuration for macOS.

## Table of Contents

- [Quick Start](#quick-start)
- [Usage](#usage)
- [File Structure](#file-structure)
- [Symlink Details](#symlink-details)
- [Manual Installation](#manual-installation-without-script)
- [Updating](#updating)
- [Notes](#notes)
- **[Tools & Usage Guide](TOOLS.md)** — Comprehensive reference for all installed tools

## Contents

- **`.zshrc`** — Zsh configuration with plugins, aliases, and tools (starship, atuin, zoxide, direnv, fzf)
- **`.zsh_aliases`** — Zsh aliases for common commands
- **`.fzf.zsh`** — Fuzzy finder setup for Zsh
- **`.gitconfig`** — Git configuration with aliases and delta integration
- **`nvim/`** — Neovim configuration (init.lua + lazy.nvim plugin manager)
- **`tmux/`** — Tmux configuration with Dracula theme and plugins (tpm, resurrect, continuum, fzf)
- **`config/starship.toml`** — Starship prompt configuration
- **`config/bat.conf`** — Bat (better cat) configuration with Dracula theme
- **`config/kitty.conf`** — Kitty terminal emulator configuration
- **`config/ghostty.conf`** — Ghostty terminal emulator configuration
- **`install.sh`** — Automated installation script

## Quick Start

### On a New Machine

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The install script will:
1. Check/install Homebrew
2. Install all necessary packages
3. Create symlinks for all config files
4. Create `~/.zsh_private` for credentials (not tracked)

### What Gets Installed

**Core tools:**
- git, neovim, tmux, zsh, fzf, ripgrep, fd

**CLI enhancements:**
- bat (better cat), eza (better ls), starship (prompt), atuin (history), zoxide (cd), direnv (env)

**Dev tools:**
- docker, lazygit, lazydocker, gh, nvm, rust, uv

**Utilities:**
- btop, ctop, jq, yq, pandoc, w3m, httpie, tldr, tree, wget, tree-sitter, glow

## Usage

### After Installation

1. **Configure Git user info (local only, not in repo):**
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

2. **Add credentials to `~/.zsh_private`:**
   ```bash
   echo 'export BITBUCKET_USERNAME="your-username"' >> ~/.zsh_private
   echo 'export BITBUCKET_PASSWORD="your-password"' >> ~/.zsh_private
   ```

3. **Install Neovim plugins:**
   ```bash
   nvim
   # First run installs all plugins automatically via lazy.nvim (~30-60 seconds)
   ```
   Once inside Neovim, run these commands to complete setup:
   ```vim
   :Lazy                              " Verify all plugins installed
   :TSUpdate                          " Install tree-sitter parsers
   :Mason                             " Install language servers and tools
   :checkhealth                       " Verify dependencies
   ```
   See [TOOLS.md](TOOLS.md#editor-neovim) for detailed setup instructions.

4. **Make Zsh your default shell:**
   ```bash
   chsh -s /bin/zsh
   ```

## File Structure

```
~/.dotfiles/
├── .zshrc           → ~/.zshrc
├── .zsh_aliases     → ~/.zsh_aliases
├── .fzf.zsh         → ~/.fzf.zsh
├── .gitconfig       → ~/.gitconfig
├── nvim/            → ~/.config/nvim/
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lua/
│   │   ├── config/  (options, keymaps, lazy, lsp)
│   │   └── plugins/ (individual plugin specs)
│   ├── snippets/    (snippet definitions)
│   └── colors/      (color schemes)
├── tmux/            → ~/.config/tmux/
│   ├── tmux.conf    (tmux config with Dracula theme + plugins)
│   └── plugins/     (tpm and plugins installed at runtime)
├── config/
│   ├── starship.toml → ~/.config/starship.toml (starship prompt config)
│   ├── bat.conf → ~/.config/bat/config (bat/better cat config)
│   ├── kitty.conf → ~/.config/kitty/kitty.conf (kitty terminal config)
│   └── ghostty.conf → ~/.config/ghostty/config (ghostty terminal config)
├── install.sh       (automated setup)
└── README.md        (this file)
```

## Symlink Details

The install script creates these symlinks:

```
~/.dotfiles/.zshrc           → ~/.zshrc
~/.dotfiles/.zsh_aliases     → ~/.zsh_aliases
~/.dotfiles/.fzf.zsh         → ~/.fzf.zsh
~/.dotfiles/.gitconfig       → ~/.gitconfig
~/.dotfiles/nvim             → ~/.config/nvim
~/.dotfiles/tmux             → ~/.config/tmux
~/.dotfiles/config/starship.toml → ~/.config/starship.toml
~/.dotfiles/config/bat.conf  → ~/.config/bat/config
~/.dotfiles/config/kitty.conf → ~/.config/kitty/kitty.conf
~/.dotfiles/config/ghostty.conf → ~/.config/ghostty/config
```

## Manual Installation (without script)

If you prefer manual control:

```bash
# Clone the repo
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles

# Install Homebrew packages (edit the list as needed)
brew install git neovim zsh fzf ripgrep fd bat eza starship atuin zoxide direnv docker lazygit gh

# Create symlinks
mkdir -p ~/.config/bat ~/.config/kitty ~/.config/ghostty
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zsh_aliases ~/.zsh_aliases
ln -s ~/.dotfiles/.fzf.zsh ~/.fzf.zsh
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/tmux ~/.config/tmux
ln -s ~/.dotfiles/config/starship.toml ~/.config/starship.toml
ln -s ~/.dotfiles/config/bat.conf ~/.config/bat/config
ln -s ~/.dotfiles/config/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/.dotfiles/config/ghostty.conf ~/.config/ghostty/config

# Create private config
touch ~/.zsh_private
```

## Updating

To pull latest changes:

```bash
cd ~/.dotfiles
git pull
```

No reinstallation needed — symlinks are permanent.

## Notes

- `.zsh_private` is never committed (add to `.gitignore`) — use it for credentials, tokens, and machine-specific config
- Neovim uses lazy.nvim for plugin management — plugins are installed on first run
- Tmux uses XDG config directory (`~/.config/tmux/tmux.conf`) — set via `XDG_CONFIG_HOME` in `.zshrc`
- Starship replaces the default prompt — configure at `~/.config/starship.toml`

## License

MIT
