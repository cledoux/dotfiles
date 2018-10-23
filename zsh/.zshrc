# vim: foldmethod=marker foldmarker={{{,}}} tw=65:

# Location of additional files for zsh
zsh_dir="$HOME/.config/zsh"

# Define Shell Environment {{{
#
# Set up shell environment here so that later
# commands will have access to full path.

# Easy access to directory storing local environment.
# Treat $LOCAL as a local root ('/')
export LOCAL="$HOME/.local"

export EDITOR='vim'
export MANPATH="$MANPATH:$LOCAL/man:$LOCAL/share/man:$LOCAL/usr/share/man"
export WINEARCH=win32

# Turn off that damn cow
export ANSIBLE_NOCOWS=1

# PATH {{{
#
# Hand build PATH
# Set up last so we have access to the other env variables.
#

# Local bin given precedence over system binaries
path=($LOCAL/bin $LOCAL/usr/bin $path)

export PATH
# }}}

# Set the colors to use for ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# }}}

# Zsh Options {{{

# Turn options on with `setopt` or `set -o`.
# Turn options off with `unsetopt` or `set +o`.
#
# Option names are case insensitive and underscores are ignored.
# For example, ‘allexport’ is equivalent to ‘A__lleXP_ort’.
#
# I have not listed all options, just the ones I want to ensure
# are turned on or off.

# Use emacs mode.
bindkey -e

# Navigation {{{

# If a command is issued that can’t be executed as a normal command,
# and the command is the name of a directory, perform the cd command
# to that directory.
unsetopt AUTO_CD

# If the argument to a cd  command  (or  an  implied  cd  with
# the AUTO_CD option set) is not a directory, and does not begin with
# a slash, try to expand the expression as if it were preceded  by  a
# `~' (see the section `Filename Expansion').
unsetopt CDABLE_VARS

# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD

# Don’t push multiple copies of the same directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS

# Do not print the directory stack after pushd or popd.
setopt PUSHD_SILENT

# }}}

# Completion {{{

# Whenever a command completion is attempted, make sure the
# entire command path is hashed first.
setopt HASH_LIST_ALL
# Do not autoselect teh first completion entry.
unsetopt MENU_COMPLETE
# Show completion menu on second tab press.
setopt AUTO_MENU
# Not just at the end
setopt COMPLETE_IN_WORD
# Go to end on completion.
setopt ALWAYS_TO_END

# Turn fancy completion on
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

#
# completion module options
# Taken from zim: https://github.com/Eriner/zim/blob/master/modules/completion/init.zsh
#

# group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'expand'
zstyle ':completion:*' squeeze-slashes true

# enable caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-${HOME}}/.zcompcache"

# ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# completion sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# smart editor completion
zstyle ':completion:*:(nano|vim|nvim|vi|emacs|e):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|webm|iso|dmg|so|o|a|bin|exe|dll|pcap|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|mobi|epub|png|jpeg|jpg|gif)'

# }}}

# History {{{

# History file options.
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# This is default, but set for share_history
setopt APPEND_HISTORY
# Save each command's beginning timestamp and the
# duration to the history file
setopt EXTENDED_HISTORY
# Delete duplicate entries before unique entries.
setopt HIST_EXPIRE_DUPS_FIRST
# Do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
# Remove command lines from the history list when the first
# character on the line is a space, or when one of the expanded
# aliases contains a leading space.
setopt HIST_IGNORE_SPACE
# Whenever the user enters a line with history expansion, don’t
# execute the line directly; instead, perform history expansion
# and reload the line into the editing buffer.
setopt HIST_VERIFY
# Append commands to history immediately
setopt INC_APPEND_HISTORY
# Share history between shells.
setopt SHARE_HISTORY
# }}}

# Input/Output {{{

# Try to correct the spelling of commands. Note that, when the
# HASH_LIST_ALL option is not set or when some directories in the
# path are not readable, this may falsely report spelling errors
# the first time some commands are used.
# The shell variable CORRECT_IGNORE may be set to a pattern to
# match words that will never be offered as corrections.
setopt CORRECT

# No c-s/c-q output freezing
unsetopt FLOW_CONTROL

# Allow use of comments in interactive code
setopt INTERACTIVE_COMMENTS

# }}}

# Job Control {{{

# Display PID when suspending processes as well
setopt LONG_LIST_JOBS

# Report the status of backgrounds jobs immediately
setopt NOTIFY

# }}}

# Expansion Options {{{

# allow expansion in prompts
setopt prompt_subst
# try to avoid the 'zsh: no matches found...'
unsetopt nomatch
# use zsh style word splitting
setopt noshwordsplit

# }}}

#}}}

# ZPlug {{{

ZPLUG_HOME=$HOME/.config/zplug
if [[ ! -e $ZPLUG_HOME ]]; then
    echo "Installing zplug"
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

# Let zplug manage itself.
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Plugins {{{

# If a plugin gives and error "command not found: compdeg",
# add `defer:2` option.
#
# A number of plugins are commented out because I don't use
# them, but think they are cool and wanted to record them.

# Avoid using Oh-my-zsh. It is slow and doesn't really add
# anything on top of existing plugins. In general, the plugins
# I want are provided elsewhere.

# Most completion needs are handled by core zsh and the
# zsh-users/zsh-completions plugin. Make sure the
# completions you want are not in one of those places before
# adding another plugin.

#
# Oh-my-zsh Plugins
# Don't use them. Period.
#

#
# Fix input
#
zplug "$zsh_dir/lib/key-bindings", from:local

#
# zsh-users plugins
#
# syntax-highlighting must be loaded before history-substring-search
zplug "zsh-users/zsh-syntax-highlighting", defer:0
zplug "zsh-users/zsh-history-substring-search", defer:1
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions", defer:3  # Always load last

#
# Utility
#
# zplug "yonchu/vimman", defer:2 # Replaced by solarized-man
zplug "horosgrisa/autoenv"
# Here's another autoenv plugin. I don't know what the difference
# between the two are, but the above looks simpler, so I went
# with it.
# zplug "Tarrasch/zsh-autoenv"
# Install and source the git secret app
zplug "sobolevn/git-secret"

#
# Make it pretty!
#
zplug "zlsun/solarized-man" # Optimized for solarized dark
zplug "$zsh_dir/themes/cledoux", from:local, as:theme # My custom themes
# zplug "Tarrasch/zsh-colors" # color commands. ex: red hi

# }}}

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# }}}

# Aliases {{{

# Common Aliases {{{
# Based on OMZ Common Aliases Plugin
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh

# ls {{{
alias ls='lscolor' # Allows default to be overwritten and reset easily.
alias lscolor='ls --color=auto' # I prefer this over --color=tty
alias l='ls -lFh'          #size,show type,human readable
alias la='ls -lAFh'        #long list,show almost all,show type,human readable
alias lr='ls -tRFh'        #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'        #long list,sorted by date,show type,human readable
alias ll='ls -lh'          #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsperm="stat -c '%A %a %n'" # List octal form of permissions
alias l.='ls -d .* --color=auto' # Show hidden files.
# }}}

# Quick access rc files {{{
alias bashrc='$EDITOR ~/.bashrc'
alias zshrc='$EDITOR ~/.zshrc'
alias vimrc='$EDITOR ~/.vimrc'
# }}}

# Searching {{{
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias fd='find . -type d -name'
alias ff='find . -type f -name'
# }}}

# Better time
alias time='/usr/bin/time -f "%C\nTime: %E real,\t%U user,\t%S sys\nSize: %K memory,\t%t set size,\t%X shared text\nCPU: %P"'

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

alias dud='du -d 1 -h'
alias duf='du -sh *'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias whereami=display_info

# Interactive copy/move {{{
# rm not present because rm drives me nuts.
alias cp='cp -i'
alias mv='mv -i'
# }}}

# }}}

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# zsh is able to auto-do some kungfoo {{{
# depends on the SUFFIX :)
if [ ${ZSH_VERSION//\./} -ge 420 ]; then
  # open browser on urls
  _browser_fts=(htm html de org net com at cx nl se dk dk php)
  for ft in $_browser_fts ; do alias -s $ft=$BROWSER ; done

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts ; do alias -s $ft=$EDITOR ; done

  _image_fts=(jpg jpeg png gif mng tiff tif xpm)
  for ft in $_image_fts ; do alias -s $ft=$XIVIEWER; done

  _media_fts=(ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts ; do alias -s $ft=mplayer ; done

  #read documents
  alias -s pdf=xdg-open
  alias -s ps=xdg-open
  alias -s dvi=xdg-open
  alias -s chm=xdg-open
  alias -s djvu=xdg-open

  #list whats inside packed file
  alias -s zip="unzip -l"
  alias -s rar="unrar l"
  alias -s tar="tar tf"
  alias -s tar.gz="echo "
  alias -s ace="unace l"
fi
# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
# }}}

# Tmux {{{
alias tmux='tmux -2'  # Force 256 colors
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tk='tmux kill-server'
# }}}

# Git {{{

# Cherry picked from OMZ git plugin.
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh

alias g='git'
alias ga='git add'
alias gc='git commit -v'
alias gcl='git clone --recursive'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gg='git gui citool'
alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias glog='git log --oneline --decorate --graph --all'
alias gm='git merge'
alias gp='git push'
alias gpd='git push --dry-run'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias gsb='git status -sb'
alias gss='git status -s'
alias gst='git status'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

# }}}

# Create yup alias to call thefuck.
# I prefer not to pollute history with profanity.
# To get new alias, run `thefuck --alias yup`.
# An eval around this command would suffice here, but I'd rather
# cache than execute. Shaves a hair off startup time.
#
# Lead space should keep yup command out of history, if history
# set up right.
alias yup=' TF_CMD=$(TF_ALIAS=yup PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1 | tail -n 1)) && eval $TF_CMD && print -s $TF_CMD'

# Always use vim
alias vi="vim"

# Ack
alias ack='ack-grep'

# Let scheme use readline
alias scheme='rlwrap -rc mit-scheme'

# Use system sqlite3 instead of the anaconda one that doesn't support
# readline
alias sqlite3='/usr/bin/sqlite3'
alias sqlite="sqlite3"


# Rsync {{{
# Stolen without shame from oh-my-zsh rsync plugin
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/rsync/rsync.plugin.zsh
#
alias rsync-copy="rsync -avz --progress -h"
alias rc='rsync-copy'
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-sync="rsync -avzu --delete --progress -h"
# }}}

alias sl='sl -e'

# Vagrant/Ansible/GCloud Aliases {{{
# Vagrant ansible
VAGRANT_DEFAULT_KEY=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
alias van="ANSIBLE_HOST_KEY_CHECKING=False ansible --inventory=${VAGRANT_DEFAULT_KEY}"
alias van-playbook="ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory=${VAGRANT_DEFAULT_KEY}"
alias gan="ANSIBLE_HOST_KEY_CHECKING=False ansible --private-key=$HOME/.ssh/google_compute_engine"
alias gan-playbook="ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --private-key=$HOME/.ssh/google_compute_engine"
# }}}

# }}}

# Functions {{{
# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
xc() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: xc <string>"
      echo "       echo <string> | xc"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

# For running gui apps in docker
docker_gui_setup() {
    export XSOCK=/tmp/.X11-unix
    export XAUTH=/tmp/.docker.xauth

    if [ ! -e  ]; then
        echo "" > $XAUTH
        xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
    else
        echo "/tmp/.docker.xauth already exists. Assuming set up correctly."
    fi

    echo "Now you can run docker gui apps with command: "
    echo 'docker run --rm -ti -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e "XAUTHORITY=$XAUTH" -e "DISPLAY=$DISPLAY" <docker image>'
}

# Use CTRL-Z to jump back and forth between vim quickly.
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# }}}

# Oh-My-Zsh Copied Plugins {{{

# A number of Oh-My-Zsh plugins are nothing but alias and
# function definitions. For the ones I wanted I've copied them
# inline to prevent having to pull in all of OMZ just for that
# simple plugin.
#
# zplug "plugins/git", from:oh-my-zsh, defer:2
# zplug "plugins/git-extras", from:oh-my-zsh

# fasd {{{

fasd_cache="${HOME}/.cache/fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

alias v="f -e $EDITOR"
alias o='a -e open_command'

# }}}

# Colorize {{{
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/colorize/colorize.plugin.zsh

# Plugin for highlighting file content
# Plugin highlights file content based on the filename extension.
# If no highlighting method supported for given extension then it tries
# guess it by looking for file content.

alias colorize='colorize_via_pygmentize'

colorize_via_pygmentize() {
    if [ ! -x "$(which pygmentize)" ]; then
        echo "package \'pygmentize\' is not installed!"
        return -1
    fi

    if [ $# -eq 0 ]; then
        pygmentize -g $@
    fi

    for FNAME in $@
    do
        filename=$(basename "$FNAME")
        lexer=`pygmentize -N \"$filename\"`
        if [ "Z$lexer" != "Ztext" ]; then
            pygmentize -l $lexer "$FNAME"
        else
            pygmentize -g "$FNAME"
        fi
    done
}

# }}}

# }}}
