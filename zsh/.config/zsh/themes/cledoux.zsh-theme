# Charles LeDoux's Theme.
# A Powerline-inspired theme for ZSH
# vim:ft=zsh ts=2 sw=2 sts=2 expandtab
#
# Fork of [eriner] which is in turn a fork of [agnoster]
# [agnoster]: https://gist.github.com/3712874 
# [eriner]: https://github.com/Eriner/zim/blob/master/modules/prompt/themes/eriner.zsh-theme
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# or at least the [Powerline symbols font](http://bit.ly/1OfGUT5).
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
PRIMARY_FG=black
SSH_FG=magenta

# Characters
function {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR="\ue0b0"
  PLUSMINUS="\u00b1"
  BRANCH="\ue0a0"
  DETACHED="\u27a6"
  CROSS="\u2718"
  LIGHTNING="\u26a1"
  GEAR="\u2699"
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n ${1} ]] && bg="%K{${1}}" || bg="%k"
  [[ -n ${2} ]] && fg="%F{${2}}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && ${1} != $CURRENT_BG ]]; then
    print -n "%{${bg}%F{${CURRENT_BG}}%}${SEGMENT_SEPARATOR}%{${fg}%}"
  else
    print -n "%{${bg}%}%{${fg}%}"
  fi
  CURRENT_BG=${1}
  [[ -n ${3} ]] && print -n ${3}
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{${CURRENT_BG}}%}\n${SEGMENT_SEPARATOR}"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {

  # Change prompt if in SSH session
  if [[ -n ${SSH_CONNECTION} ]]; then
    prompt_segment ${SSH_FG} default " %(!.%{%F{yellow}%}.)${USER}@%m "
  else
    prompt_segment ${PRIMARY_FG} default " %(!.%{%F{yellow}%}.)${USER}@%m "
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(command git status --porcelain --ignore-submodules)"
  }
  ref=${vcs_info_msg_0_}
  if [[ -n ${ref} ]]; then
    if is_dirty; then
      color=yellow
      ref="${ref} ${PLUSMINUS}"
    else
      color=green
      ref="${ref} "
    fi
    if [[ "${ref/.../}" == ${ref} ]]; then
      ref="${BRANCH} ${ref}"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    prompt_segment ${color} ${PRIMARY_FG}
    print -Pn " ${ref}"
  fi
}

# Shortens the pwd for use in prompt
short_pwd() {

  local current_dir="${1:-${PWD}}"
  local return_dir='~'

  current_dir="${current_dir/#${HOME}/~}"

  # if we aren't in ~
  if [[ ${current_dir} != '~' ]]; then
    return_dir="${${${${(@j:/:M)${(@s:/:)current_dir}##.#?}:h}%/}//\%/%%}/${${current_dir:t}//\%/%%}"
  fi

  print ${return_dir}
}

# Dir: current working directory
prompt_dir() {
  prompt_segment cyan ${PRIMARY_FG} " ${PWD/#$HOME/~} "
  # To get a much shorter PWD in prompt:
  # prompt_segment cyan ${PRIMARY_FG} " $(short_pwd) "
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ ${RETVAL} -ne 0 ]] && symbols+="%{%F{red}%}${CROSS}"
  [[ ${UID} -eq 0 ]] && symbols+="%{%F{yellow}%}${LIGHTNING}"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}${GEAR}"

  [[ -n ${symbols} ]] && prompt_segment ${PRIMARY_FG} default " ${symbols} "
}

# Python virtual environment status.
prompt_venv() {
  # Assume $VIRTUAL_ENV set if in venv.
  if [ "x$VIRTUAL_ENV" != 'x' ]; then
    RPROMPT='hi there '
    prompt_segment ${PRIMARY_BG}cyan ${PRIMARY_FG} "(venv: `basename \"$VIRTUAL_ENV\"`)"
  fi
}

## Main prompt
prompt_eriner_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_status
  prompt_venv
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

prompt_eriner_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_eriner_main) '
}

prompt_eriner_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_eriner_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_eriner_setup "$@"
