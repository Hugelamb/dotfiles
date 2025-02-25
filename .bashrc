# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#-----------------------------------
# Source global definitions (if any)
#-----------------------------------


if [ -f /etc/bashrc ]; then
    . /etc/bashrc 
fi
#-----------------------------------
# Source global definitions (if any)
#-----------------------------------

set -o ignoreeof

#-----------------------------------
# Greeting, motd, colors, etc
#-----------------------------------

# Color definitions
# Custom Colors
cyellow='[38;5;220m'
cblue='[38;5;20m'
cpink='[38;5;13m'
colive='[38;2;137;129;83m'
cgreen='[38;2;70;179;19m'
ccrimson='[38;2;242;42;90m'
# Normal colors
black='[0;30m'
red='[0;31m'
green='[0;32m'
yellow='[0;33m'
blue='[0;34m'
purple='[0;35m'
cyan='[0;36m'
white='[0;37m'

# Bold colors

bblack='[1;30m'
bred='[1;31m'
bgreen='[1;32m'
byellow='[1;33m'
bblue='[1;34m'
bpurple='[1;35m'
bcyan='[1;36m'
bwhite='[1;37m'

# Background colours

on_black='[40m'
on_red='[41m'
on_green='[42m'
on_yellow='[43m'
on_blue='[44m'
on_purple='[45m'
on_cyan='[46m'
on_white='[47m'

NC="[m"


ALERT=${bwhite}${on_red}    # Bold white on red background (hi-contrast)

#------------------------------------------------
# Shell Prompt Customization
#------------------------------------------------

# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
    CNX=${Green}        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
    CNX=${ALERT}        # Connected on remote machine, not via ssh (bad).
else
    CNX=${BCyan}        # Connected on local machine.
fi

# Test User Type
if [[ ${USER} == "root" ]]; then
    SU=${brown}
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# customize bash prompt (style and colors)
# PS1='\[[38;5;220m[\]\u[38;5;20m@[38;5;220m\h\] [38;5;13m\w[38;5;220m \$ [0m'
# [\]\u@\h\] \w\$  
PS1='\[${colive}\][\[${cyellow}\]\u\[${cblue}\]@\[${cyellow}\]\h\[${colive}\]] \[${cpink}\]\w \[${cyellow}\]\$\[${NC}\]'
#------------------------------------------------
# Commands
#------------------------------------------------

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Check if given path exists, if it does, add to $PATH
prepend_path () {
    if [[ -d $1 ]]; then
        export PATH="$1:$PATH"
    fi
} 
#------------------------------------------------
# Aliases
#------------------------------------------------
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# bare dotfiles repo command 
alias dots='/usr/bin/git --git-dir=/home/"$USER"/.dotfiles/ --work-tree=/home/"$USER"'

# grim screenshot aliases
# take screenshot using output of slurp and save to $HOME/Pictures/Screenshots
# Filename will be in format of {YYYYMMDD}_{HH}h{MM}m{SS}s.png, 
# I.e. 20250101_12h12m12s.png would be from 1/1/2025, at 12 seconds past 12:12
alias screenshot='slurp | grim -g - ${HOME}/Pictures/Screenshots/$(date "+%Y%m%d_%Hh%Mm%Ss.png")'
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

# alias todo app 
alias in='task add +in'
alias tt='task +DUE list'
# add to bash prompt
# change color based on number of pending tasks
#------------------------------------------------
# Paths
#------------------------------------------------

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# add BOOST root directory to path
export PATH="/usr/include/boost_1_82_0:$PATH"

# if neovim installed from github release, use that version
if [[ -d /opt/nvim-linux64/bin ]]; then
    export PATH="$PATH:/opt/nvim-linux64/bin"
fi
# add neovim config to path
export EDITOR="nvim"
export PATH="$HOME/.config/nvim:$PATH"
# add colorschemes to lua path
export LUA_PATH=";;$HOME/.config/nvim/colors/?.lua;$LUA_PATH"
# add lua snippets to path
export LUA_PATH="$HOME/.config/nvim/?.lua;$LUA_PATH"
export LUA_PATH="$HOME/.config/nvim/luasnippets/?.lua;$LUA_PATH"

# add tex environment variables
if [[ -d /media ]]; then
  export MANPATH="/media/tex/texmf-dist/doc/man:$MANPATH"
  export INFOPATH="/media/tex/texmf-dist/doc/info:$INFOPATH"
  prepend_path "/media/tex/bin/x86_64-linux"
else
  export MANPATH="/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH"
  export INFOPATH="/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"
  prepend_path "/usr/local/texlive/2024/bin/x86_64-linux"
fi
prepend_path "$HOME/.local/bin"

# add mupdf fileviewer binary to path
prepend_path "$HOME/.mupdf/bin"

# add cargo to path (for macchina)
prepend_path "$HOME/.cargo/bin"
#------------------------------------------------
# Custom Commands
#------------------------------------------------
# print customized shell using macchina 
shopt -q login_shell && macchina --config $HOME/.config/macchina/macchina-login.toml --theme minimal || macchina --theme Mikasa
# add task inbox to prompt
inbox_prompt() {
  inbox_count=$(task +in +PENDING count)
  if [ $inbox_count -gt 0 ]; then
    count_color=$ccrimson
  else
    count_color=$cgreen
  fi
  echo -e "${count_color}"
}

# set PS1
if [[ ! $(command -v task 2>&1 >/dev/null) ]]     # command -v prints the location of input command if present in $PATH, otherwise returns failure status (1).
then
  export PS1='\[$(inbox_prompt)\]$(task +in +PENDING count) '$PS1               # prepend number of unprocessed inbox decisions to prompt, separate task call for prompt length calculations
fi

