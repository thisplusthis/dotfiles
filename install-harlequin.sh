#!/usr/bin/env zsh
# Install and configure Harlequin SQL IDE with secure credential handling
# Uses `uv` for fast, reliable Python package management

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"
VENV_DIR="$HOME_DIR/.virtualenvs/harlequin"

echo -e "${BLUE}🔧 Harlequin Setup (using uv)${NC}\n"

# Check for uv
if ! command -v uv &> /dev/null; then
    echo -e "${RED}✗ uv is not installed${NC}"
    echo -e "${YELLOW}→ Install with:${NC} brew install uv"
    exit 1
fi

echo -e "${GREEN}✓${NC} uv is available ($(uv --version))"

# Step 1: Create virtualenv with uv
echo -e "${BLUE}📦 Setting up Python virtualenv with uv...${NC}"
if [[ -d "$VENV_DIR" ]]; then
    echo -e "${GREEN}✓${NC} Virtualenv already exists at $VENV_DIR"
else
    echo -e "${YELLOW}→${NC} Creating virtualenv at $VENV_DIR..."
    uv venv "$VENV_DIR" >/dev/null 2>&1
    echo -e "${GREEN}✓${NC} Virtualenv created"
fi

# Step 2: Install Harlequin with uv
echo -e "${BLUE}📚 Installing Harlequin...${NC}"
if "$VENV_DIR/bin/pip" show harlequin >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Harlequin already installed"
else
    echo -e "${YELLOW}→${NC} Installing Harlequin with MySQL adapter..."
    uv pip install --python "$VENV_DIR/bin/python" harlequin-mysql >/dev/null 2>&1
    echo -e "${GREEN}✓${NC} Harlequin installed"
fi

# Step 3: Check for credentials
echo -e "${BLUE}🔐 Checking for Harlequin credentials...${NC}"

REQUIRED_VARS=(
    "HARLEQUIN_HOST"
    "HARLEQUIN_PORT"
    "HARLEQUIN_USER"
    "HARLEQUIN_PASSWORD"
    "HARLEQUIN_DATABASE"
)

MISSING_VARS=()
for var in "${REQUIRED_VARS[@]}"; do
    # Bash-compatible indirect variable expansion
    if [[ -z "${!var}" ]]; then
        MISSING_VARS+=("$var")
    fi
done

if [[ ${#MISSING_VARS[@]} -gt 0 ]]; then
    echo -e "${YELLOW}⚠${NC} Missing credentials. Set these in ${BLUE}~/.zsh_private${NC}:\n"
    cat << 'EOF'
# Harlequin SQL IDE (Atlas database)
export HARLEQUIN_HOST="127.0.0.1"
export HARLEQUIN_PORT=3306
export HARLEQUIN_USER="atlas"
export HARLEQUIN_PASSWORD="atlas"
export HARLEQUIN_DATABASE="atlas"
EOF
    echo -e "\n${YELLOW}→${NC} Add these to ~/.zsh_private and run: ${BLUE}source ~/.zsh_private${NC}"
    echo -e "${YELLOW}→${NC} Then re-run this script: ${BLUE}$0${NC}\n"
    exit 1
else
    echo -e "${GREEN}✓${NC} All credentials found"
fi

# Step 4: Generate config from dotfiles version with credentials injected
echo -e "${BLUE}⚙️  Generating Harlequin config...${NC}"

CONFIG_FILE="$HOME_DIR/.harlequin.toml"
SOURCE_FILE="$DOTFILES_DIR/config/harlequin.toml"

# Verify source config exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo -e "${RED}✗${NC} Config file not found: $SOURCE_FILE"
    exit 1
fi

# Generate ~/.harlequin.toml with credentials from environment variables
cat > "$CONFIG_FILE" << EOF
# Harlequin SQL IDE Configuration
# Generated from: ~/dev/dotfiles/config/harlequin.toml
# Credentials injected from: ~/.zsh_private

default_profile = "atlas"

[profiles.atlas]
type = "mysql"
host = "$HARLEQUIN_HOST"
port = $HARLEQUIN_PORT
user = "$HARLEQUIN_USER"
password = "$HARLEQUIN_PASSWORD"
database = "$HARLEQUIN_DATABASE"
theme = "monokai"
EOF

echo -e "${GREEN}✓${NC} Config generated at $CONFIG_FILE"
echo -e "${GREEN}✓${NC} Source config: $SOURCE_FILE (tracked in git, no credentials)"

# Step 5: Create convenience alias
echo -e "${BLUE}🔗 Setting up shell alias...${NC}"
if grep -q "alias hq=" "$HOME_DIR/.zsh_aliases" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Alias already exists in ~/.zsh_aliases"
else
    echo "alias hq='$VENV_DIR/bin/harlequin'" >> "$HOME_DIR/.zsh_aliases"
    echo -e "${GREEN}✓${NC} Added 'hq' alias to ~/.zsh_aliases"
fi

echo -e "\n${GREEN}✅ Harlequin setup complete!${NC}\n"
echo -e "Usage:"
echo -e "  ${BLUE}hq${NC}              — Open Harlequin SQL IDE"
echo -e "  ${BLUE}hq --help${NC}       — Show help\n"
echo -e "Next steps:"
echo -e "  1. Run ${BLUE}source ~/.zsh_private${NC} or restart your shell"
echo -e "  2. Try ${BLUE}hq${NC} to launch Harlequin\n"
