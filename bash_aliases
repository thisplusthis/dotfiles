###################
# GENERAL ALIASES #
###################
alias l='ls -alth'                      # last modified list
alias h='history'                       # shortcut for history
alias c='clear'                         # shortcut to clear the shell
alias ..='cd ..'                        # move up 1 dir
alias ...='cd ../..'                    # move up 2 dirs
alias dev='cd ~/dev/'
alias nv='nvim'
alias ebash='nvim ~/.bash_profile'
alias sbash='source ~/.bash_profile'
alias sshconfig='nvim ~/.ssh/config'       # edit ssh config file
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias apps='cd ~/Applications'
alias nvide='nv ~/.config/nvim/'

###################
# GIT ALIASES #
###################
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias gl='git lg'
alias gbr='git branch -a'
alias gr='git rm'
alias gpl='git pull origin $1'
alias gps='git push origin $1'

###################
# PYTHON ALIASES #
###################
alias py='python3'
alias djpro='django-admin.py startproject '$1''  # new django project
alias djsync='python manage.py makemigrations; python manage.py migrate'
alias djshell='python manage.py shell'

###################
# DOCKER ALIASES
###################
alias dk='docker'
alias dkl='docker logs'
alias dklf='docker logs -f'
alias dki='docker image'
alias dkil='docker image ls'
alias dkc='docker container'
alias dkcl='docker container ls'
alias dks='docker service'
alias dkr='docker run'
alias dkrm='docker rm'
alias dkv='docker volume'
alias dkvl='docker volume ls'
alias dkp='docker system prune -a --volumes'
alias dkpr='docker system prune --volumes'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcr='docker compose restart'
