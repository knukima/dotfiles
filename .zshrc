zmodload zsh/datetime
typeset -g _zsh_t0=$EPOCHREALTIME

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_dups

export PATH="/home/user/.local/bin:$PATH"

alias cls='clear'
alias ls='lsd -a'
alias ff='fastfetch'
alias ..='cd ..'
alias ...='cd ../..'
alias dc='cd'
alias g='git'
alias md='mkdir'

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

eval "$(dircolors -b)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

_fastboot_files() {
  if [[ ${words[2]} == flash && $CURRENT -ge 4 ]]; then
    _files
  else
    _fastboot "$@"
  fi
}
compdef _fastboot_files fastboot

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

setopt prompt_subst
autoload -Uz add-zsh-hook

typeset -g git_info _git_branch _git_dirty _git_fd
typeset -g _git_g=$''
typeset -g _git_d=$' '

_git_render() {
  git_info=
  [[ -n $_git_branch ]] || return
  local dirty=
  [[ $_git_dirty == 1 ]] && dirty=" %F{208}${_git_d}%f"
  git_info=" %F{magenta}(${_git_g} ${_git_branch//\%/%%}${dirty}%F{magenta})%f"
}

_git_callback() {
  local fd=$1 line
  if [[ -z $2 || $2 == hup ]]; then
    IFS= read -r -u $fd line
    [[ -n $line ]] && _git_dirty=1
    _git_render
    zle reset-prompt
  fi
  zle -F $fd
  exec {fd}<&-
  _git_fd=
}

_git_precmd() {
  if [[ -n $_git_fd ]]; then
    zle -F $_git_fd 2>/dev/null
    exec {_git_fd}<&- 2>/dev/null
    _git_fd=
  fi
  _git_dirty=
  _git_branch=$(git symbolic-ref --short -q HEAD 2>/dev/null) \
    || _git_branch=$(git rev-parse --short HEAD 2>/dev/null) \
    || _git_branch=
  _git_render
  [[ -n $_git_branch ]] || return
  exec {_git_fd}< <(GIT_OPTIONAL_LOCKS=0 git status --porcelain --ignore-submodules=dirty 2>/dev/null | head -n 1)
  zle -F $_git_fd _git_callback
}
add-zsh-hook precmd _git_precmd

shebang

PROMPT='%F{green}%n@%m%f %B%F{blue}%2~%f%b${git_info} %(?.%F{green}.%F{red})%#%f '

export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)

printf '\e[38;5;223mWelcome Home...\e[0m\n'
printf '\e[3;38;5;240m'"zsh started in %.7f seconds"'\e[0m\n' $(( EPOCHREALTIME - _zsh_t0 ))
unset _zsh_t0
