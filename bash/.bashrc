# vim: foldmethod=marker foldmarker={{{,}}} tw=65:

# Load system specific file first
[[ -e "$HOME/.bashrc.system" ]] && source "$HOME/.bashrc.system"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Bash Sensible Defaults {{{
# Original from https://raw.githubusercontent.com/mrzool/bash-sensible/master/sensible.bash
# Customizations have been made.

# sensible Bash - An attempt at saner Bash defaults
# Maintainer: mrzool <http://mrzool.cc>
# Repository: https://github.com/mrzool/bash-sensible
# Version: 0.2.2

# Unique Bash version check
if ((BASH_VERSINFO[0] < 4))
then
  echo "sensible.bash: Looks like you're running an older version of Bash."
  echo "sensible.bash: You need at least bash-4.0 or some options will not work correctly."
  echo "sensible.bash: Keep your software up-to-date!"
fi

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Tab through the possible completions for ambiguous patterns
# This works more like vim tab complete than zsh.
# bind 'TAB:menu-complete'

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Examples:
# export dotfiles="$HOME/dotfiles"
# export projects="$HOME/projects"
# export documents="$HOME/Documents"
# export dropbox="$HOME/Dropbox"

# }}}

# HISTORY Control {{{

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
# PROMPT_COMMAND='history -a'

# Huge history. {{{
# Only enable one of huge history or unlimited history.
# HISTSIZE=500000
# HISTFILESIZE=100000
# }}}

# Unlimited History {{{
# Only enable one of huge history or unlimited history.
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# }}}

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# }}}


# Environment {{{

# Preferred defaults
export EDITOR=vim

# Include snap directory in path if it exists.
if [[ -e "/snap/bin" ]]; then
    export PATH="$PATH:/snap/bin"
fi

# Local path overrides system.
export PATH="$HOME/.local/bin:$PATH"

# refresh function to reload environment variables in tmux.
# If updating the list of variables, also need to update the
# `set -g update-environment` command in tmux.conf
# The update-environment config will reload the variables into
# tmux on reattach.  This function will load the variables into
# the shell.
if [[ -n "$TMUX" ]]; then
	# https://raimue.blog/2013/01/30/tmux-update-environment/
	function refresh() {
        cd .
		local v
		while read v; do
			if [[ $v == -* ]]; then
				unset ${v/#-/}
			else
				# Add quotes around the argument
				v=${v/=/=\"}
				v=${v/%/\"}
				eval export $v
			fi
		done < <(tmux show-environment)
        # Reload prompt because it is based on some environment variables
        [[ -e "$HOME/.bashrc.prompt" ]] && source "$HOME/.bashrc.prompt"
	}
else
    # Define the function as a nop outside of tmux so we can set
    # this function to automatically run (e.g. in a preexec) without fear.
    refresh(){ :; }
fi

#}}}

# Go Configuration {{{

# Add location of go files.
export GOPATH="$HOME/.local/go"
# Add go binaries to path.
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"
# All other environment configs are stored at this location.
export GOENV="$GOPATH/config"

# }}}

# Aliases {{{

# Load common alias file.
[[ -e "$HOME/.aliasrc" ]] && source "$HOME/.aliasrc"

# Some ls aliases
alias l='ls -CF'
alias ll='ls -alhF'
alias la='ls -A'

# Open a tunnel.  Used for connection reuse
alias sshopen='ssh -f -N'
# List open sockets
alias sshsocks='ls ~/.ssh/sockets'
# Create reverse SSH
alias sshrev='ssh -f -N -R 9999:localhost:22'

# SQLite aliases
alias sqlite='sqlite3'

# Git alaises
alias gc='git commit'
alias ga='git add'
alias gl='git pull'
alias gp='git push'
alias gst='git status'

# HG aliases
alias hadd='hg add'
alias hc='hg commit'
alias ha='hg amend'
alias hl='hg xl'
alias hu='hg uploadchain'
alias hua='hg amend && hg uploadchain'
alias hau='hg amend && hg uploadchain'
alias hs='hg status'
alias hco='hg checkout'
alias hfix='hg fix'

# Golang aliases
alias gofind="find -type f -name '*.go'"
alias gofix="gofind | xargs goimports -w"
alias gosimple="gofind | xargs gofmt -s -w"
# glaze needs to come last in case the formatted removes imports.
alias goall="gofix && gosimple && glaze ... "


# }}}

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

