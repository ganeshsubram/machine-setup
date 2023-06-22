# System
alias refresh='source ~/.bashrc'
alias cue='code ~/.bash_aliases'
alias machine='cd ~/machine-setup'
alias code_machine='code ~/machine-setup'
# File system
alias exp='xdg-open .'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../..'
alias .....='cd ../../../../..'
alias ......='cd ../../../../../..'
alias .......='cd ../../../../../../..'
# Git
alias gb='git branch'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gpf='git push -f'
alias gco='git checkout master'
alias gcom='git checkout main'
alias gal='git add --all'
alias grbi='git rebase -i main'
alias cane='git commit --amend --no-edit'
# Tmux
alias tmux_refresh='tmux source-file ~/.tmux.conf'
# Glydways
alias code_gld='code ~/glyd'
alias gld='cd ~/glyd'
alias gldmake='~/glyd/make.sh'
alias glddc='~/glyd/build/glyd_data_collection'
alias gldgui='~/glyd/build/glyd_data_collection_gui'
alias xsens='cd ~/glyd/third_party/xsens_mt'
alias ark='cd ~/glyd/third_party/ark'
alias ncom='cd ~/glyd/third_party/oxts_ncom_sdk'
alias oxts='cd ~/glyd/glyd/onboard/imu/oxts'
# SSH
# alias orin='tailscale ssh glydways@charmander-orin'
# alias orientexpress='ssh orientexpress@192.168.64.147'  # Wi-Fi, pw: Glydways1
# alias orientexpresslte='ssh orientexpress@10.17.1.22'   # LTE, pw: Glydways1
# alias ontarioexpress='ssh ontarioexpress@192.168.65.96' # Wi-fi, pw: Glydways1
# alias ontarioexpresslte='ssh ontarioexpress@10.64.3.11' # LTE, pw: Glydways1
# Docker
alias docker_enable='systemctl --user enable docker-desktop'
alias docker_start='systemctl --user start docker-desktop'
alias docker_stop='systemctl --user stop docker-desktop'
