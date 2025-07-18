# vim: foldmethod=marker foldmarker={{{,}}} tw=65:

# Load system specific file first
[[ -e "$HOME/.bashrc.system" ]] && source "$HOME/.bashrc.system"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Start with the sensible defaults configuration
[[ -e "$HOME/.bashrc.defaults" ]] && source "$HOME/.bashrc.defaults"

# Load aliases.
[[ -e "$HOME/.aliasrc" ]] && source "$HOME/.aliasrc"

# Debian Defaults {{{
# These were taken from a default debian .bashrc

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# }}}

# Load the prompt
[[ -e "$HOME/.bashrc.prompt" ]] && source "$HOME/.bashrc.prompt"

# Load local overrides last.
[[ -e "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"

# Load in locally stored sensitive variables.
[[ -e "$HOME/.bashrc.secrets" ]] && source "$HOME/.bashrc.secrets"
