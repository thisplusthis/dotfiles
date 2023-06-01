set term=xterm-256color

#Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Private things
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi

# User specific environment and startup programs

# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:$PATH:$HOME/bin

export EDITOR='nvim'
export CLICOLOR=1
export PYTHONSTARTUP=$HOME/.pythonrc.py

BLACK="\033[0;30m"
BLUE="\033[0;34m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
PURPLE="\033[0;35m"
BROWN="\033[0;33m"
LIGHTGRAY="\033[0;37m"
DARKGRAY="\033[1;30m"
LIGHTBLUE="\033[1;34m"
LIGHTGREEN="\033[1;32m"
LIGHTCYAN="\033[1;36m"
LIGHTRED="\033[1;31m"
LIGHTPURPLE="\033[1;35m"
YELLOW="\033[1;33m"
WHITE="\033[1;37m"
BLINK_BLACK="\033[5;30m"
BLINK_BLUE="\033[5;34m"
BLINK_GREEN="\033[5;32m"
BLINK_CYAN="\033[5;36m"
BLINK_RED="\033[5;31m"
BLINK_PURPLE="\033[5;35m"
BLINK_BROWN="\033[5;33m"
BLINK_LIGHTGRAY="\033[5;1;37m"
BLINK_DARKGRAY="\033[5;1;30m"
BLINK_LIGHTCYAN="\033[5;1;36m"
BLINK_LIGHTRED="\033[5;1;31m"
BLINK_LIGHTPURPLE="\033[5;1;35m"
BLINK_YELLOW="\033[5;33m"
BLINK_WHITE="\033[5;37m"
NORMAL="\033[0;0m"

function parse_git_branch (){
    git branch 2> /dev/null | grep '*' | sed 's#*\ \(.*\)#(git::\1)#'
}

function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function b64() {
    echo -n "$1" | base64
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
makezip() { zip -r "${1%%/}.zip" "$1" ; }

gpip(){
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

export PIP_REQUIRE_VIRTUALENV=true

export GIT_EDITOR="$vim"
#customized prompt
export PS1='\[\e[0;36m\][\u]\[\e[0;33m\][\w]\n\[\e[0;35m\]$(parse_git_branch)> \[\e[0m\]'
