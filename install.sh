#!/usr/bin/env zsh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

echo -e "${BLUE}🔧 Dotfiles Install Script${NC}\n"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}⚠️  Homebrew not found. Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

echo -e "${GREEN}✓ Homebrew is installed${NC}\n"

# Install Homebrew packages
echo -e "${BLUE}📦 Installing Homebrew packages...${NC}"

PACKAGES=(
    # Version control & git tools
    git
    lazygit
    gh
    delta

    # Editors & shells
    neovim
    zsh
    tmux

    # Search & find
    fzf
    ripgrep
    fd

    # Better CLI tools
    bat
    eza
    starship
    atuin
    zoxide
    direnv

    # Docker tools
    docker
    lazydocker

    # Monitoring
    btop
    ctop
    dust

    # Data tools
    jq
    yq

    # Development
    nvm
    rust
    uv
    ipython

    # Code formatters & linters (system-level)
    prettier
    black
    isort
    stylua
    shellcheck

    # Utilities
    pandoc
    w3m
    httpie
    tldr
    tree
    wget
    tree-sitter
    glow
)

for package in "${PACKAGES[@]}"; do
    if brew list "$package" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $package (already installed)"
    else
        echo -e "${YELLOW}→${NC} Installing $package..."
        brew install "$package"
    fi
done

echo -e "\n${GREEN}✓ All packages installed${NC}\n"

# Install Nerd Fonts
echo -e "${BLUE}🔤 Installing Nerd Fonts...${NC}"

# Tap homebrew-cask-fonts if not already tapped
if ! brew tap | grep -q homebrew/cask-fonts; then
    echo -e "${YELLOW}→${NC} Tapping homebrew/cask-fonts..."
    brew tap homebrew/cask-fonts
fi

FONTS=(
    font-mononoki-nerd-font
)

for font in "${FONTS[@]}"; do
    if brew list "$font" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $font (already installed)"
    else
        echo -e "${YELLOW}→${NC} Installing $font..."
        brew install --cask "$font"
    fi
done

echo -e "\n${GREEN}✓ Nerd Fonts installed${NC}\n"

# Create symlinks
echo -e "${BLUE}🔗 Creating symlinks...${NC}"

# Helper function to create symlink
create_symlink() {
    local src="$1"
    local dest="$2"

    if [[ ! -e "$dest" ]]; then
        ln -s "$src" "$dest"
        echo -e "${GREEN}✓${NC} $dest"
    elif [[ -L "$dest" ]] && [[ $(readlink "$dest") == "$src" ]]; then
        echo -e "${GREEN}✓${NC} $dest (already linked)"
    else
        echo -e "${YELLOW}⚠${NC} $dest already exists and differs. Skipping."
    fi
}

# Symlink shell configs
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME_DIR/.zshrc"
create_symlink "$DOTFILES_DIR/.fzf.zsh" "$HOME_DIR/.fzf.zsh"
create_symlink "$DOTFILES_DIR/.zsh_aliases" "$HOME_DIR/.zsh_aliases"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME_DIR/.gitconfig"

# Symlink neovim, tmux, and other tool configs
mkdir -p "$HOME_DIR/.config" "$HOME_DIR/.config/bat" "$HOME_DIR/.config/kitty" "$HOME_DIR/.config/ghostty"
create_symlink "$DOTFILES_DIR/nvim" "$HOME_DIR/.config/nvim"
create_symlink "$DOTFILES_DIR/tmux" "$HOME_DIR/.config/tmux"
create_symlink "$DOTFILES_DIR/config/starship.toml" "$HOME_DIR/.config/starship.toml"
create_symlink "$DOTFILES_DIR/config/bat.conf" "$HOME_DIR/.config/bat/config"
create_symlink "$DOTFILES_DIR/config/kitty.conf" "$HOME_DIR/.config/kitty/kitty.conf"
create_symlink "$DOTFILES_DIR/config/ghostty.conf" "$HOME_DIR/.config/ghostty/config"

# Remove legacy ~/.tmux.conf if it exists (so tmux uses ~/.config/tmux/tmux.conf instead)
if [[ -f "$HOME_DIR/.tmux.conf" ]] && [[ ! -L "$HOME_DIR/.tmux.conf" ]]; then
    echo -e "${YELLOW}→${NC} Removing legacy ~/.tmux.conf (tmux will now use ~/.config/tmux/tmux.conf)..."
    rm "$HOME_DIR/.tmux.conf"
fi

# Create .zsh_private if it doesn't exist (for credentials/tokens)
if [[ ! -f "$HOME_DIR/.zsh_private" ]]; then
    cat > "$HOME_DIR/.zsh_private" << 'EOF'
# .zsh_private — Git credentials, API keys, etc.
# This file is NOT tracked in the dotfiles repo

# Example:
# export GITHUB_TOKEN="your-token-here"
# export BITBUCKET_USERNAME="your-username"
# export BITBUCKET_PASSWORD="your-password"
EOF
    echo -e "${GREEN}✓${NC} Created ~/.zsh_private (edit with your credentials)"
else
    echo -e "${GREEN}✓${NC} ~/.zsh_private (already exists)"
fi

echo -e "\n${GREEN}✓ All symlinks created${NC}\n"

# Source .zshrc if zsh is the current shell
if [[ "$SHELL" == */zsh ]]; then
    echo -e "${BLUE}🔄 Reloading shell configuration...${NC}"
    exec zsh
else
    echo -e "${YELLOW}⚠️  Current shell is not zsh. Run:${NC}"
    echo -e "  ${BLUE}chsh -s /bin/zsh${NC}"
    echo -e "  ${BLUE}exec zsh${NC}"
fi

echo -e "\n${GREEN}✅ Installation complete!${NC}"
echo -e "Don't forget to:"
echo -e "  1. Edit ${BLUE}~/.zsh_private${NC} with your credentials (BITBUCKET_USERNAME, BITBUCKET_PASSWORD, etc.)"
echo -e "  2. Run ${BLUE}nvim${NC} and let lazy.nvim install plugins (${BLUE}:Lazy${NC})"
echo -e "  3. Run ${BLUE}source ~/.zshrc${NC} or restart your terminal\n"
