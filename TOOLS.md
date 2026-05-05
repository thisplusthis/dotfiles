# Tools & Usage Guide

Complete reference for the tools configured in this dotfiles repository.

## Table of Contents

- [Shell (Zsh)](#shell-zsh)
  - [Aliases](#aliases)
  - [Shell Functions](#shell-functions)
- [Terminal Multiplexer (Tmux)](#terminal-multiplexer-tmux)
- [Editor (Neovim)](#editor-neovim)
- [Prompt (Starship)](#prompt-starship)
- [Fuzzy Finder (Fzf)](#fuzzy-finder-fzf)
- [SQL IDE (Harlequin)](#sql-ide-harlequin)
- [Terminal Emulators](#terminal-emulators)
- [Version Control (Git)](#version-control-git)
- [CLI Tools](#cli-tools)
- [Development Tools](#development-tools)
- [Code Formatters & Linters](#code-formatters--linters)
- [Quick Reference: Daily Workflow](#quick-reference-daily-workflow)
- [Troubleshooting](#troubleshooting)
- [Further Reading](#further-reading)

---

## Shell (Zsh)

**Config:** `~/.zshrc` + `~/.zsh_aliases`

Zsh is your primary shell with modern plugins and integrations.

### Key Features

- **Syntax highlighting** — Colored command syntax as you type
- **Auto-suggestions** — Suggests commands from history
- **History search** — `Ctrl+R` for fuzzy history search (via atuin)
- **Smart cd** — `z` command (zoxide) for frecent directory jumping
- **Auto .env loading** — Automatically loads `.env` files (direnv)

### Common Commands

```bash
# Source config after editing
source ~/.zshrc

# Edit zshrc
ezsh    # Opens ~/.zshrc in nvim
szsh    # Reloads ~/.zshrc

# Directory shortcuts (zoxide)
z project           # Jump to frecent "project" directory
zi                  # Interactive directory picker

# Functions available
extract archive.tar.gz    # Auto-detects format and extracts
maketar directory/        # Create .tar.gz
makezip directory/        # Create .zip
workon projectname        # Activate venv
gpip install package      # Pip install without venv (sudo)
```

### Aliases

**Navigation:**
```bash
..          # cd ..
...         # cd ../..
dev         # cd ~/dev
downloads   # cd ~/Downloads
```

**Tools:**
```bash
l           # ls with git status
lt          # ls tree (level 2)
cat         # bat (syntax highlighting)
nvim → nv   # Shortcut for neovim
```

**Git:**
```bash
ga          # git add
gc          # git commit
gs          # git status
gd          # git diff
gl          # git lg (pretty log)
gbr         # git branch -a
```

**Docker:**
```bash
dps         # docker ps (formatted)
dpsa        # docker ps -a (formatted)
dlog        # docker logs -f (last 50)
dexec       # docker exec -it (interactive bash)
dcr         # docker stop + remove all containers
```

### Shell Functions

Custom functions defined in `.zshrc`:

**Directory & Files:**
```bash
extract archive.tar.gz     # Auto-extract any archive format (.tar.gz, .zip, .rar, etc.)
maketar directory/         # Create tar.gz from directory
makezip directory/         # Create zip from directory
```

**Development:**
```bash
workon projectname         # Activate virtualenv (searches .venv or ~/.virtualenvs/)
workon                     # Activate local .venv if present
gpip install package       # Pip install without venv requirement (uses sudo)
```

**Encoding:**
```bash
b64 "string"              # Base64 encode
```

**Git:**
```bash
gbranch                   # Interactive fuzzy branch checkout (select branch with fzf)
```

**Docker:**
```bash
dsi container_name        # Stop container by name/pattern
drmi container_name       # Remove container by name/pattern
```

**Search & Code Navigation:**
```bash
rg-fzf "pattern"          # Ripgrep + fzf: search files interactively
                          # Shows matching lines, preview with context
                          # Select result to jump to file:line
```

**Versions:**
```bash
versions                  # Show versions of Node, Python, Ruby, Go, Rust, Docker, Git, Make
```

**Auto-detection Functions (smart runners):**
```bash
test                      # Auto-detect and run tests (npm test, pytest, make test)
lint                      # Auto-detect and run linter (npm lint, ruff, make lint)
format                    # Auto-detect and run formatter (npm format, ruff, make format)
build                     # Auto-detect and run build (npm build, make, python build)
serve                     # Auto-detect and run dev server (npm dev/start, Django, make serve)
```

---

## Terminal Multiplexer (Tmux)

**Config:** `~/.config/tmux/tmux.conf`

Tmux allows you to manage multiple terminal sessions, windows, and panes.

### Configuration

- **Prefix key:** `Ctrl-s` (instead of default `Ctrl-b`)
- **Theme:** Dracula with CPU, battery, and time widgets
- **Scrollback:** 50,000 lines per pane
- **Mouse:** Enabled for scrolling and pane selection

### Key Bindings

**Note:** `prefix` = `Ctrl-s` (not the default `Ctrl-b`)

**Sessions:**
```
prefix s        # List/select sessions
prefix d        # Detach from session
prefix $        # Rename session
prefix :        # Command prompt
```

**Windows:**
```
prefix c        # Create new window
prefix n        # Next window
prefix p        # Previous window
prefix l        # Last window (toggle)
prefix w        # List/select windows
prefix &        # Kill window
prefix ,        # Rename window
Alt+→           # Next window (without prefix)
Alt+←           # Previous window (without prefix)
```

**Panes:**
```
prefix |        # Split left/right (preserves cwd)
prefix -        # Split top/bottom (preserves cwd)
prefix h/j/k/l  # Navigate panes (vim-style)
prefix Ctrl+h/j/k/l  # Resize panes by 5 lines (repeatable)
prefix space    # Toggle pane layouts
prefix {        # Swap pane left
prefix }        # Swap pane right
prefix !        # Break pane into new window
prefix x        # Kill pane
```

**Copy Mode (for selecting & copying text):**
```
prefix [        # Enter copy mode
/               # Search forward
?               # Search backward
hjkl            # Navigate (vim-style)
Space           # Start selection
Enter           # Copy selection (copies to clipboard via tmux-yank)
q               # Exit copy mode
```

**Configuration & Maintenance:**
```
prefix r        # Reload ~/.config/tmux/tmux.conf
prefix R        # Refresh client (updates terminal size)
prefix ?        # List all keybindings
```

### Commands

```bash
# Attach to/create session
tmux new -s projectname
tmux attach -t projectname
tmux ls                     # List sessions

# From inside tmux
prefix :list-keys          # Show all keybindings
```

### Plugins

Installed via **tpm** (Tmux Plugin Manager):

- **tmux-sensible** — Sensible defaults
- **vim-tmux-navigator** — Seamless vim/tmux navigation
- **tmux-yank** — Improved copy/paste
- **tmux-resurrect** — Save/restore sessions
- **tmux-continuum** — Auto-save sessions
- **tmux-fzf** — Fuzzy finding in tmux
- **extrakto** — Extract URLs, paths, etc. from panes

---

## Editor (Neovim)

**Config:** `~/.config/nvim/`

Modern Vim-like editor with LSP, treesitter, and plugins via lazy.nvim.

### First Run

```bash
nvim                # First run installs plugins via lazy.nvim (takes ~30-60 seconds)
```

Once inside Neovim, complete these setup steps:

**1. Verify plugin installation:**
```vim
:Lazy                  " Check that all plugins installed successfully
:checkhealth           " Verify dependencies (nvim, python, node, etc.)
```

**2. Install Treesitter parsers** (syntax highlighting):
```vim
:TSUpdate              " Install/update tree-sitter parsers for all languages
:TSInstall python javascript typescript lua bash json yaml markdown html css
```

**3. Install language servers & tools** (via Mason):
```vim
:Mason                 " Opens interactive package manager
```

Install these (common recommendations):
- **Python:** `python-lsp-server`, `debugpy`, `black`, `isort`
- **JavaScript/TypeScript:** `eslint_d`, `prettier`, `typescript-language-server`
- **Lua:** `lua-language-server`, `stylua`
- **General:** `shellcheck` (bash), `jsonls` (JSON)

Search by typing the name (e.g. `/python-lsp`), then press `i` to install.

**4. Verify LSP setup:**
```vim
:checkhealth lsp       " Check LSP configuration
:LspInfo               " Show installed LSP servers
```

### Leader Key

Default leader: `,` (comma)

### Core Features

- **LSP** — Language Server Protocol for intellisense, diagnostics, goto def, rename, etc.
- **Treesitter** — Syntax highlighting and text objects
- **Telescope** — Fuzzy finding for files, buffers, grep
- **Completion** — cmp with nvim-cmp
- **Formatting** — conform.nvim with prettier, black, etc.
- **Git** — gitsigns, fugitive, diffview

### Common Keybindings

**Window Navigation & Resizing:**
```
Ctrl+h/j/k/l       # Navigate between splits (Vim-style)
Ctrl+Up/Down       # Resize split vertically (-/+ 2 lines)
Ctrl+Left/Right    # Resize split horizontally (-/+ 2 columns)
```

**LSP & Diagnostics:**
```
gd                 # Go to definition
gr                 # Go to references
K                  # Hover (documentation)
Ctrl+k Ctrl+h      # Signature help
Space+e            # Open diagnostics float
]d                 # Next diagnostic
[d                 # Previous diagnostic
Space+q            # Set diagnostics to location list
```

**Telescope (Fuzzy Finding):**
```
,ff                # Find files
,fb                # Find buffers
,fg                # Grep in cwd
,fh                # Help tags
```

**Editing:**
```
gcc                # Toggle comment (line)
gc                 # Toggle comment (visual selection)
=                  # Format selection
==                 # Format line
<, >               # Keep selection after indent (visual mode)
s, S               # Flash jump (motion plugin)
```

**Code Actions & Formatting:**
```
,ca                # Code action
,rn                # Rename symbol
,f                 # Format document
```

**Debugging** (requires debugger to be running):
```
,db                # Toggle breakpoint
,dB                # Conditional breakpoint
,dc                # Continue execution
,di                # Step into
,dn                # Step over (next)
,do                # Step out
,dr                # Open REPL
,dl                # Run last
,dt                # Terminate debugger
,du                # Toggle DAP UI
```

### Commands

```vim
:Mason                    " Manage LSP/formatters/linters
:Lazy                     " Plugin manager
:Telescope live_grep      " Grep in files
:Telescope find_files     " Find files
:Telescope buffers        " List buffers
:vsplit                   " Vertical split
:split                    " Horizontal split
:only                     " Close all other windows
:bdelete                  " Close buffer
:vert term                " Open vertical terminal
```

---

## Prompt (Starship)

**Config:** `~/.config/starship.toml`

Minimal, fast, customizable prompt showing:

```
[user] [path] [python-venv] [node-version] [duration]
(git::branch) [git-status] [> or > (error)]
```

### Elements Shown

- **Username** — Cyan, always shown
- **Directory** — Yellow path (truncated to 4 levels)
- **Git branch** — Purple with icon
- **Git status** — Red if dirty (modified, untracked, staged, deleted)
- **Python** — Blue when in virtualenv
- **Node** — Green when `package.json` exists
- **Duration** — Time taken for last command (if > 2s)

### Customization

Edit `~/.config/starship.toml` to change:
- Colors (use any 256-color or hex)
- Format string (which elements to show)
- Thresholds (e.g., min command duration to show)

---

## Fuzzy Finder (Fzf)

**Config:** `~/.fzf.zsh`

Interactive fuzzy finder integrated into zsh.

### Key Bindings

```
Ctrl+T          # Fuzzy find files and cd to directory
Ctrl+R          # Search shell history (via atuin)
Alt+C           # Fuzzy find directory and cd
```

### Usage

```bash
# Find and open file in editor
vim $(fzf)

# Find and kill process
kill -9 $(pgrep -l node | fzf | awk '{print $1}')

# Search git history
git log --oneline | fzf

# cd to directory
cd $(find . -type d | fzf)
```

### Configuration

- **Default command:** `fd --type f --hidden --follow --exclude .git`
- **Preview:** Syntax highlighted with bat
- **Multi-select:** `Tab` to select multiple items

---

## SQL IDE (Harlequin)

**Setup:** `./install-harlequin.sh` | **Config:** `~/.harlequin.toml` (auto-generated)

Terminal-based SQL IDE with support for MySQL, DuckDB, SQLite, and more.

### Installation & Credentials

1. **Set credentials in `~/.zsh_private`:**
   ```bash
   # Harlequin SQL IDE (Atlas database)
   export HARLEQUIN_HOST="127.0.0.1"
   export HARLEQUIN_PORT=3306
   export HARLEQUIN_USER="atlas"
   export HARLEQUIN_PASSWORD="atlas"
   export HARLEQUIN_DATABASE="atlas"
   ```

2. **Run the setup script:**
   ```bash
   ~/dev/dotfiles/install-harlequin.sh
   ```
   This will:
   - Create `~/.virtualenvs/harlequin` virtualenv
   - Install Harlequin + MySQL adapter
   - Generate `~/.harlequin.toml` from your credentials
   - Add `hq` alias to `~/.zsh_aliases`

3. **Reload shell:**
   ```bash
   source ~/.zsh_private
   ```

### Usage

```bash
hq                  # Launch Harlequin (uses default "atlas" profile)
hq --help           # Show help
hq -P none          # Launch without default profile
```

### Navigation

Inside Harlequin:

```
Ctrl+N              # Next pane
Ctrl+P              # Previous pane
Ctrl+F              # Search
Ctrl+T              # Toggle Data Catalog
Ctrl+Q              # Quit
```

### Features

- **Syntax highlighting** — SQL syntax in editor
- **Data Catalog** — Browse tables, columns, indexes
- **Results Viewer** — Query results with sorting/filtering
- **Auto-complete** — Table & column names
- **History** — Query history (accessible via search)

### Configuration

The config is **auto-generated** from your credentials in `~/.zsh_private`. To update:

1. Edit credentials in `~/.zsh_private`
2. Re-run: `~/dev/dotfiles/install-harlequin.sh`

**Note:** `~/.harlequin.toml` is git-ignored for security.

---

## Terminal Emulators

### Kitty

**Config:** `~/.config/kitty/kitty.conf` (96KB)

Modern GPU-accelerated terminal emulator.

**Features:**
- Font: Mononoki Nerd Font (13pt)
- Theme: Dracula (via kitty-themes)
- Ligatures enabled
- True color support
- Scrollback: default (2000 lines)

**Key Commands:**
```bash
kitten icat image.png           # View images in terminal
kitten diff file1 file2         # Diff two files
kitten choose-fonts             # Font selection UI
```

**Kitten Shortcuts (default):**
```
Ctrl+Shift+Alt+t    # New tab
Ctrl+Shift+Alt+n    # New OS window
Ctrl+Shift+Alt+l    # Next layout
Ctrl+Shift+Enter    # New window in current tab
```

### Ghostty

**Config:** `~/.config/ghostty/config` (1.3KB)

Newer, lighter terminal emulator mirroring kitty settings.

**Features:**
- Font: Mononoki Nerd Font (13pt)
- Theme: Atelier Seaside Dark
- Color scheme: Merged from kitty
- Split divider color: Dark green

**Key Differences:**
- Faster startup than kitty
- Smaller memory footprint
- ANSI palette-generate enabled

---

## Version Control (Git)

**Config:** `~/.gitconfig`

Comprehensive git aliases and delta diff integration.

### Delta Integration

Git diffs use **delta** for:
- Side-by-side comparison
- Line numbers
- Syntax highlighting
- Color theme: Dracula

### Adding & Committing

**Stage changes:**
```
git a           # add . (stage all changes)
git ai          # add -i (interactive — choose which hunks to stage)
```

**Commit:**
```
git c           # commit (opens editor for detailed message)
git cm "msg"    # commit -m (quick commit with message)
git ca          # commit -a (commit all tracked files)
git cam         # commit -am (stage all + commit in one)
```

**Amend last commit:**
```
git cd          # commit --amend (edit last commit message)
git cad         # commit -a --amend (add changes + amend last commit)
```

**Common workflow:**
```bash
# Stage specific changes interactively
git ai                          # Pick which hunks to stage

# Quick commit
git cm "Fix typo in README"

# Or if you forgot to stage
git cam "Add new feature"       # Stage all tracked + commit

# Oops, forgot something
git add docs/
git cad                         # Add to last commit
```

**Other commit variants:**
```
git cem         # commit --allow-empty -m (empty commit, useful for triggering CI)
git ced         # commit --allow-empty --amend (amend with empty commit)
```

### Quick Status & Inspection

```
git s           # status
git sb          # status -s -b (short, with branch)
git d           # diff (unstaged changes)
git dc          # diff --cached (staged changes)
```

**Branches & remotes:**
```
git b           # git branch
git ba          # git branch -a
git bd          # git branch -d
git o           # git checkout
git ob          # git checkout -b
git f           # git fetch
git pl          # git pull
git ps          # git push
git pso         # git push origin
```

**History & inspection:**
```
git l           # git log --oneline
git lg          # git log --graph (pretty)
git w           # git show
git wp          # git show -p (with patch)
```

**Rebase & merge:**
```
git rb          # git rebase
git rbi         # git rebase -i (interactive)
git m           # git merge
git ma          # git merge --abort
git pb          # git pull --rebase
```

### Pushing & Pulling Without Origin

The most common push/pull aliases work with your tracking branch automatically — no need to specify `origin`:

**Push (to tracked remote):**
```
git ps              # push (uses upstream tracking)
git psu             # push -u (set upstream on first push)
git psf             # push -f (force push)
```

**Pull (from tracked remote):**
```
git pl              # pull (from upstream tracking)
git pb              # pull --rebase (rebase instead of merge)
```

**How it works:** When you create a branch locally and push with `-u` (e.g. `git psu`), Git tracks which remote branch it came from. After that, `git ps` and `git pl` automatically use that tracking branch — no need to say `git ps origin` or `git pl origin`.

**Example workflow:**
```bash
# Create and push new feature branch
git ob feature/my-thing      # checkout -b (create branch)
git add .
git commit -m "My changes"
git psu                      # push -u origin feature/my-thing (sets tracking)

# Later, just use short form
git pl                       # pull from origin feature/my-thing
git ps                       # push to origin feature/my-thing
```

**If you need to push/pull from origin explicitly:**
```
git pso             # push origin (current branch)
git plo             # pull origin (current branch)
```

**Note:** This works because `.gitconfig` has `pull.rebase = true`, so pulls default to rebase (cleaner history) unless you have merge commits.

### User Config

Must set locally (not in repo):
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

## CLI Tools

### Bat (Better Cat)

**Config:** `~/.config/bat/config`

Syntax-highlighted file viewer with line numbers and git changes.

```bash
bat file.py                    # View file with highlighting
bat --list-themes              # List available themes
bat --theme Dracula file.py    # Use specific theme
```

**Theme:** Dracula
**Options:** Line numbers, git changes, header

### Eza (Better Ls)

Drop-in replacement for `ls` with colors, icons, and git integration.

```bash
l                  # Aliased: eza -la with git status
ls                 # Aliased: eza with icons
lt                 # Tree view (level 2)
```

### Delta (Better Git Diffs)

Syntax-highlighted side-by-side git diffs with line numbers.

**Already configured** in `.gitconfig` for all git commands:
```bash
git diff                # Shows side-by-side diffs with syntax highlighting
git log -p              # Shows commits with delta diffs
git show               # Shows commit details with delta diffs
```

**Theme:** Dracula
**Features:** Side-by-side comparison, line numbers, syntax highlighting, merge conflict markers

### Starship (Already Covered Above)

### Atuin

Command history manager with search and statistics.

```bash
atuin search "command"         # Search history
atuin history                  # Show history
atuin stats                    # Show statistics
```

**Features:**
- Synced history across machines (optional)
- Context-aware suggestions
- Full history search with `Ctrl+R`

### Zoxide (Smart Cd)

Tracks most-used directories and helps you jump to them quickly.

```bash
z projectname          # Jump to frecent "projectname"
zi                    # Interactive picker
z -                   # Previous directory
```

### Direnv

Automatically loads `.env` files when entering a directory.

```bash
# In project directory
direnv allow          # Trust the .envrc
direnv deny           # Remove trust
```

### Dust (Disk Usage)

Better alternative to `du` command for analyzing disk space usage.

```bash
dust                  # Show disk usage in current directory
dust /path/to/dir    # Show disk usage of specific directory
dust -r              # Reverse sort (largest first)
dust -n 10           # Show top 10 directories
dust -d 2            # Limit depth to 2 levels
```

**Features:**
- Cleaner output than `du`
- Human-readable sizes (KB, MB, GB)
- Colored output
- Faster than `du`
- Tree-like visualization

### Lazygit

Interactive git UI in the terminal.

```bash
lazygit               # Start interactive git UI
```

**Key Features:**
- View diffs
- Stage/unstage interactively
- Create/checkout branches
- Commit, squash, rebase

### Lazydocker

Interactive docker UI in the terminal.

```bash
lazydocker            # Start interactive docker UI
```

### Glow

Terminal markdown viewer with syntax highlighting and pagination.

```bash
glow README.md                     # View markdown file
glow                              # View all markdown files in current directory
glow -p README.md                 # View in pager mode
glow --style dark README.md       # Use dark style
glow --style light README.md      # Use light style
```

**Features:**
- Syntax highlighting for code blocks
- Table formatting
- Auto-pagination for large files
- Multiple style options (dark, light, pink, dracula)
- Useful for reading documentation and commit messages

### Ripgrep (Better Grep)

Ultra-fast recursive search tool, respects `.gitignore` by default.

```bash
rg "pattern"                       # Search for pattern in files
rg "pattern" -A 2 -B 2            # Show context (2 lines before/after)
rg "pattern" --type rust          # Search only Rust files
rg "pattern" src/                 # Search specific directory
rg "^TODO"                        # Regex support
rg -i "pattern"                   # Case-insensitive
```

**Features:**
- Respects `.gitignore` (no searching vendor, node_modules, etc.)
- Multi-threaded by default
- Regex support
- Very fast (faster than grep, ack, ag)
- Type filtering (`--type rust`, `--type python`, etc.)

**Integration:** Used in `rg-fzf` shell function for interactive fuzzy search (see Shell Functions below).

### Jq

Command-line JSON processor for parsing and transforming JSON.

```bash
jq '.' file.json                  # Pretty-print JSON
jq '.name' file.json              # Extract field
jq '.items[] | .id' file.json     # Extract array elements
jq 'map(.price) | add' file.json  # Sum prices
curl https://api.example.com | jq '.data | length'  # Count API results
```

**Features:**
- Powerful query language
- Filters, transformations, grouping
- Works with streams
- Much better than grep/sed for JSON

### Yq

YAML processor (like jq but for YAML).

```bash
yq '.name' config.yaml            # Extract field
yq '.servers[0].host' config.yaml # Array access
yq 'eval' file.yaml               # Pretty-print YAML
yq '.metadata |= . + {"new": "field"}' input.yaml  # Merge
```

### Tree

Directory tree visualization.

```bash
tree                              # Show tree of current directory
tree -L 2                         # Limit depth to 2 levels
tree -I 'node_modules'            # Exclude directories
tree -h                           # Human-readable file sizes
tree -a                           # Include hidden files
```

**Note:** Also available as simple alias `lt` (eza tree mode).

### Httpie

Human-friendly HTTP client for testing APIs.

```bash
http GET example.com              # Simple GET
http POST example.com name=value  # POST with JSON body
http -a user:pass GET example.com # Basic auth
http --headers GET example.com    # Show response headers only
http --form POST example.com file@/path/to/file  # File upload
```

**Features:**
- Cleaner syntax than curl
- Automatic JSON formatting
- Cookie support
- Session management

### Btop

System resource monitor (CPU, memory, disk, network).

```bash
btop                              # Launch interactive monitor
# Inside btop:
# - 'q' to quit
# - 1-4 to toggle graphs
# - 'h' for help
```

**Features:**
- Real-time CPU, memory, disk, network monitoring
- Per-process view
- Color-coded by usage
- Customizable layout

### Ctop

Docker container monitoring (like btop but for containers).

```bash
ctop                              # Launch interactive container monitor
# Inside ctop:
# - 'q' to quit
# - ↑↓ to navigate containers
# - 'e' to exec into container
# - 'l' to see logs
```

### w3m

Terminal web browser.

```bash
w3m https://example.com           # Open website
w3m duckduckgo.com                # Search (aliased as 'web')
# Inside w3m:
# - 'q' to quit
# - 'j/k' to scroll
# - 'H' for help
```

### Wget

File downloader.

```bash
wget https://example.com/file.zip # Download file
wget -r https://example.com       # Recursive download (mirror site)
wget -O custom.zip https://example.com/file.zip  # Rename on download
```

### Tldr

Simplified man pages with practical examples.

```bash
tldr ls                           # Show common usage of ls
tldr grep                         # Show common grep patterns
tldr --list                       # List all available pages
tldr --update                     # Update local pages
```

**Features:**
- Much simpler than `man` pages
- Practical examples
- Community-driven
- Works offline

### Ipython

Enhanced Python REPL with features like syntax highlighting, auto-completion, and magic commands.

```bash
ipython                           # Start interactive shell
ipython file.py                   # Run Python file with interactive shell after
# Inside ipython:
# - %time statement              # Time execution
# - %timeit statement             # Benchmark
# - %history                      # Show history
# - %run file.py                 # Run file
```

**Features:**
- Syntax highlighting
- Tab completion
- Magic commands
- Shell access (!)
- Better than python REPL

---

## Development Tools

### Python

```bash
uv venv                        # Create venv
source .venv/bin/activate      # Activate
workon project                 # Activate specific venv
pip                            # Aliased to uv pip
uv pip install package         # Install package
```

**Configuration:**
- `PIP_REQUIRE_VIRTUALENV=true` — Forces venv usage

### Node.js

Managed via **nvm** (Node Version Manager).

```bash
nvm install 20                 # Install Node 20
nvm use 20                     # Switch to Node 20
nvm alias default 20           # Set default
```

### Rust

```bash
cargo new projectname          # Create new project
cargo build                    # Build
cargo run                      # Run
cargo test                     # Test
```

### Docker

```bash
dps                  # docker ps (formatted table)
dpsa                 # docker ps -a (all containers)
dlog <container>     # docker logs -f (last 50 lines)
dexec <container>    # docker exec -it <container> bash
dcr                  # Stop and remove all containers
```

**Environment variables:**
```bash
COMPOSE_DOCKER_CLI_BUILD=0     # Use docker build, not buildkit
DOCKER_BUILDKIT=0              # Disable buildkit
```

---

## Code Formatters & Linters

System-level formatters installed for command-line use and Neovim integration.

### Prettier (JavaScript/TypeScript/JSON)

```bash
prettier file.js                # Format file (prints to stdout)
prettier --write file.js        # Format in-place
prettier --write src/           # Format entire directory
prettier --check file.js        # Check if formatted (exit 0/1)
```

### Black (Python)

```bash
black file.py                   # Format file
black src/                      # Format directory
black --check file.py           # Check formatting
```

### isort (Python imports)

```bash
isort file.py                   # Sort imports in-place
isort src/                      # Sort imports in directory
isort --check file.py           # Check import sorting
```

### stylua (Lua)

```bash
stylua file.lua                 # Format Lua file
stylua src/                     # Format directory
stylua --check file.lua         # Check formatting
```

### shellcheck (Bash/Shell)

```bash
shellcheck script.sh            # Lint shell script
shellcheck -S style script.sh   # Check with style warnings
```

**Integration:** All formatters are configured in Neovim via conform.nvim. They can also be used standalone from the command line for batch formatting.

---

## Quick Reference: Daily Workflow

### Starting Work

```bash
# Enter project directory
z projectname        # Jump via zoxide

# Create/activate venv
workon projectname   # Or uv venv + source

# Start tmux session
tmux new -s work

# Open editor
nvim .

# Optional: Open second pane for server
prefix -             # Split pane
python manage.py runserver
```

### Common Tasks

**Edit files:**
```
nvim file.py         # Open editor
:Telescope find_files # Find file in project
,ff                  # (from nvim) Find files
Ctrl+T               # (in zsh) Fuzzy find file
```

**Check git status:**
```
git s                # Quick status
lazygit              # Interactive view
Ctrl+G               # (if bound in editor)
```

**Search codebase:**
```
,fg                  # (from nvim) Grep in cwd
grep -r "text" .     # Standard grep
```

**Run tests:**
```
make test            # If Makefile exists
pytest               # Python tests
npm test             # Node tests
```

---

## Troubleshooting

**Zsh doesn't load:**
```bash
source ~/.zshrc
# Or restart terminal
```

**Tmux colors look wrong:**
```bash
tmux kill-server
tmux new-session     # Start fresh
```

**Neovim plugins not installing:**
```vim
:Lazy sync           # Sync all plugins
:Lazy update         # Update all plugins
```

**Git not using delta:**
```bash
which delta          # Verify installed
git config --global core.pager delta
```

**Zoxide not jumping:**
```bash
z -i                 # Interactive picker
zi                   # Same thing
z --list             # Show frecent dirs
```

---

## Further Reading

- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)
- [Tmux Manual](https://man.openbsd.org/tmux)
- [Neovim Docs](https://neovim.io/doc/)
- [Starship Config](https://starship.rs/config/)
- [Fzf Wiki](https://github.com/junegunn/fzf/wiki)
- [Git Aliases](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases)
