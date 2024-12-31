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
# Greeting, motd, colors, etc.
#-----------------------------------

# Color definitions


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
# source user dotfiles if available
for dotfile in ~/.{bash_aliases,path,exports,functions} ;
    do [[ -f $dotfile ]] && . $dotfile || echo $dotfile not found. ;
done

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
PS1='\[[38;5;220m[\]\u[38;5;20m@[38;5;220m\h [38;5;13m\W[38;5;220m]\$ [0m'


################
### Commands ###
################

# spice up your terminal with macchina
# not in login shell 
shopt -q login_shell && macchina --config $HOME/.config/macchina/macchina-login.toml --theme minimal || macchina --theme Mikasa

# dotfiles git bare repo alias creation
# alias dotfiles='/usr/bin/git --git-dir=/home/"$USER"/.dotfiles/ --work-tree=/home/"$USER"'

