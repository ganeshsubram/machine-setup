# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

###################################################################################
# Ganesh's Mods
###################################################################################

#
# SSH
#

# Start ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# For Loading the SSH key
# /usr/bin/keychain -q --nogui $HOME/.ssh/id_ed25519
source $HOME/.keychain/$(hostname)-sh

ssh_env() {
  if [ $# -lt 1 ]; then
    echo "Usage: ssh_env user@host [ssh args...]"
    return 1
  fi

  local target="$1"
  shift

  local payload
  payload="$(
    {
      [ -f "$HOME/.bashrc" ] && cat "$HOME/.bashrc"
      echo
      [ -f "$HOME/.bash_aliases" ] && cat "$HOME/.bash_aliases"
    } | base64 -w0
  )"

  ssh -t "$target" "$@" "
    tmp=\$(mktemp) &&
    echo '$payload' | base64 -d > \"\$tmp\" &&
    export DISABLE_AUTO_TMUX=1 &&
    exec bash --rcfile \"\$tmp\" -i
  "
}


#
# Coloring
#

export TERM=xterm-256color
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

COLOR_BLACK='0;30'
COLOR_RED='0;31'
COLOR_GREEN='0;32'
COLOR_BROWN='0;33'
COLOR_BLUE='0;34'
COLOR_MAGENTA='0;35'
COLOR_CYAN='0;36'
COLOR_WHITE='0;37'
BOLD_COLOR_BLACK='01;30'
BOLD_COLOR_RED='01;31'
BOLD_COLOR_GREEN='01;32'
BOLD_COLOR_BROWN='01;33'
BOLD_COLOR_BLUE='01;34'
BOLD_COLOR_MAGENTA='01;35'
BOLD_COLOR_CYAN='01;36'
BOLD_COLOR_WHITE='01;37'

#
# Git
#

git_prune_merged() {
  # Ensure we’re inside a git repo
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
    echo "Not inside a git repository"
    return 1
  }

  # Make sure main exists locally
  if ! git show-ref --verify --quiet refs/heads/main; then
    echo "Local 'main' branch not found"
    return 1
  fi

  # Update main (optional but recommended)
  git fetch origin main >/dev/null 2>&1

  # Switch to main to avoid deleting current branch
  current_branch=$(git branch --show-current)
  if [ "$current_branch" != "main" ]; then
    git checkout main || return 1
  fi

  # Delete all branches merged into main except main itself
  git branch --merged main \
    | grep -vE '^\*|main$' \
    | xargs -r git branch -d
}


# git branch coloring
parse_git_branch() { git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[${BOLD_COLOR_GREEN}m\]\u@\h\[\033[00m\]:\[\033[${BOLD_COLOR_BLUE}m\]\w/\[\033[${BOLD_COLOR_BROWN}m\]\$(parse_git_branch) \[\033[00m\]\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac


#
# Aliases
#

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

#
# FZF
#

source /usr/share/doc/fzf/examples/key-bindings.bash

#
# History
#

# source: https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
# don't put duplicate lines or lines starting with space in the history.

HISTCONTROL=ignoreboth
# HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
# source: https://stackoverflow.com/questions/12247777/share-history-between-panes-windows
export PROMPT_COMMAND="history -a; history -n"

#
# Tmux
#

# Start terminal in a tmux session by default
if command -v tmux &>/dev/null && \
   [ -z "$TMUX" ] && \
   [ -z "$DISABLE_AUTO_TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

#
# WSL
#
if [ ! -f /usr/local/bin/code ]; then
    sudo ln -s /mnt/c/Program\ Files/Microsoft\ VS\ Code/bin/code /usr/local/bin/code
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Set default display
export DISPLAY=:0.0

# Required for GPU accelerated GUIs
export MESA_D3D12_DEFAULT_ADAPTER_NAME=nvidia

# Asus disables GPU on battery, so switch to software rendering if there's no NVIDIA gpu.
# Using nvidia-smi since in WSL we won't see ant NVIDIA devices in lspci
nvidia_output=$(nvidia-smi 2>&1)
if [[ "$nvidia_output" == *"Failed to initialize NVML"* ]]; then
  export LIBGL_ALWAYS_SOFTWARE=1
    echo
    echo -e "\e[33mNVIDIA GPU not detected, switching to software rendering"
    echo
fi

#
# Claude
#

export CLAUDE_CODE_MAX_OUTPUT_TOKENS=64000

#
# Glydways
#
source ~/glyd/bazel/bash_completion/bazel-complete.bash
source ~/glyd/glyd/dev/env/env-setup.sh
export PATH="$PATH:$HOME/glyd/scripts/bin"
