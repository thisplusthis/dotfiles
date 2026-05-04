# .zshrc

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Completions
autoload -Uz compinit && compinit

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# PATH
export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"

# Environment
export TERM=xterm-256color
export EDITOR='nvim'
export CLICOLOR=1
export GIT_EDITOR='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# eza colors — magenta/cyan scheme
export EZA_COLORS="di=1;36:ln=35:ex=1;32:*.py=36:*.js=36:*.ts=36:*.jsx=36:*.tsx=36:*.html=35:*.css=35:*.scss=35:*.json=2;36:*.toml=2;36:*.yaml=2;36:*.yml=2;36:*.md=2;37:*.sh=32:*.gz=1;31:*.zip=1;31:*.tar=1;31:da=2;37:sn=37:sb=2;37:ga=32:gm=35:gd=31"

# Python
export PIP_REQUIRE_VIRTUALENV=true

# Docker
export COMPOSE_DOCKER_CLI_BUILD=0
export DOCKER_BUILDKIT=0

# Tmux — XDG config directory (prevents tmux from looking at legacy ~/.tmux.conf)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Aliases (all aliases defined in ~/.zsh_aliases)
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# Private config (credentials, tokens, etc.)
[ -f ~/.zsh_private ] && source ~/.zsh_private

# zoxide (smart cd) - replaces `cd` with `z`
eval "$(zoxide init zsh)"
# direnv - auto-loads .env on cd
eval "$(direnv hook zsh)"

# fzf fuzzy finder
source ~/.fzf.zsh

# fd
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'                                                                 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Functions
function parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's#* \(.*\)#(git::\1)#'
}

function extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)   tar xvjf "$1"   ;;
            *.tar.gz)    tar xvzf "$1"   ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xvf "$1"    ;;
            *.tbz2)      tar xvjf "$1"   ;;
            *.tgz)       tar xvzf "$1"   ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }
function makezip() { zip -r "${1%%/}.zip" "$1"; }
function b64() { echo "$1" | base64; }
function gpip() { PIP_REQUIRE_VIRTUALENV="" pip "$@"; }
function workon() {
    if [ -n "$1" ]; then
        source ~/.virtualenvs/$1/bin/activate
    elif [ -f .venv/bin/activate ]; then
        source .venv/bin/activate
    else
        echo "No .venv found. Run: uv venv"
    fi
}
function dsi() { docker stop $(docker ps -a | awk -v i="^$1.*" '{if($2~i){print$1}}'); }
function drmi() { docker rm $(dsi "$1" | tr '\n' ' '); }

# Git: checkout branch with fzf
function gbranch() {
    git branch -a | grep -v HEAD | sed 's/^[* ]*//' | sed 's#^remotes/##' | sort -u | fzf | xargs -r git checkout
}

# Search project with ripgrep + fzf
function rg-fzf() {
    rg --color=always --line-number --no-heading "$@" 2>/dev/null | fzf --ansi --preview 'echo {} | cut -d: -f1,2 | xargs -I {} sh -c "echo {} && sed -n \$(echo {} | cut -d: -f2)p \$(echo {} | cut -d: -f1)"' | cut -d: -f1,2
}

# View versions of common tools
function versions() {
    echo "=== Development Tools ===" && \
    echo "Node: $(node -v 2>/dev/null || echo 'not installed')" && \
    echo "npm: $(npm -v 2>/dev/null || echo 'not installed')" && \
    echo "Python: $(python3 --version 2>/dev/null || echo 'not installed')" && \
    echo "Ruby: $(ruby -v 2>/dev/null || echo 'not installed')" && \
    echo "Go: $(go version 2>/dev/null || echo 'not installed')" && \
    echo "Rust: $(rustc --version 2>/dev/null || echo 'not installed')" && \
    echo "" && \
    echo "=== Build & Deployment ===" && \
    echo "Docker: $(docker --version 2>/dev/null || echo 'not installed')" && \
    echo "Git: $(git --version 2>/dev/null || echo 'not installed')" && \
    echo "Make: $(make --version 2>/dev/null | head -1 || echo 'not installed')"
}

# Run tests (auto-detect)
function test() {
    if [ -f "package.json" ]; then
        npm test "$@"
    elif [ -f "pytest.ini" ] || [ -f "pyproject.toml" ]; then
        pytest "$@"
    elif [ -f "Makefile" ]; then
        make test "$@"
    else
        echo "No test runner found (npm test, pytest, or make test)"
    fi
}

# Format/lint code (auto-detect)
function lint() {
    if [ -f "package.json" ]; then
        npm run lint "$@" 2>/dev/null || echo "No lint script in package.json"
    elif [ -f "ruff.toml" ] || [ -f "pyproject.toml" ]; then
        ruff check . "$@"
    elif [ -f "Makefile" ]; then
        make lint "$@"
    else
        echo "No linter found (npm lint, ruff, or make lint)"
    fi
}

# Format code (auto-detect)
function format() {
    if [ -f "package.json" ]; then
        npm run format "$@" 2>/dev/null || echo "No format script in package.json"
    elif [ -f "ruff.toml" ] || [ -f "pyproject.toml" ]; then
        ruff format . "$@"
    elif [ -f "Makefile" ]; then
        make format "$@"
    else
        echo "No formatter found (npm format, ruff, or make format)"
    fi
}

# Build project (auto-detect)
function build() {
    if [ -f "package.json" ]; then
        npm run build "$@"
    elif [ -f "Makefile" ]; then
        make build "$@"
    elif [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
        python -m build "$@"
    else
        echo "No build system found (npm, make, or python build)"
    fi
}

# Serve/run development server (auto-detect)
function serve() {
    if [ -f "package.json" ]; then
        npm run dev "$@" 2>/dev/null || npm run start "$@" 2>/dev/null || npm start "$@"
    elif [ -f "manage.py" ]; then
        python manage.py runserver "$@"
    elif [ -f "Makefile" ]; then
        make serve "$@"
    else
        echo "No server found (npm dev/start, Django, or make serve)"
    fi
}

# Prompt (remove or comment the next line to revert to the block below)
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

# Fallback prompt — uncomment to revert to original
# autoload -Uz colors && colors
# PROMPT='%{$fg[cyan]%}[%n]%{$fg[yellow]%}[%~]
# %{$fg[magenta]%}$(parse_git_branch)> %{$reset_color%}'
