[[ -o login ]] && source ~/.profile

# prompt
# putting it early because my chpwd hook messes up some modules
eval "$( starship init zsh )"

# zsh settings {{{
# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt autocd extendedglob nomatch notify auto_continue hist_ignore_space extended_history hist_ignore_all_dups
unsetopt beep

autoload -Uz compinit
compinit

# do completion by matching stuff from middle
# https://unix.stackexchange.com/a/259511
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

# ctrl-w removes whole arg, add delimeters
# https://stackoverflow.com/a/11200998
export WORDCHARS='*?_[]~=&;!#$%^(){}<>'
# }}}

# antigen {{{
source /usr/share/zsh/share/antigen.zsh
antigen init ~/.config/antigen/antigenrc
# }}}

# plugin settings {{{
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

# automatically source venv on cd
add-zsh-hook -Uz chpwd (){ [ -f .env ] && source .env; [ -d venv ] && source venv/bin/activate }
# }}}

# completion {{{
# pip
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip3

# kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
compctl -K __start_kubectl k

# kitty grep
compdef _rg kg
# }}}

# misc {{{
# aliases
# source ~/.aliases

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER=';;'
export FZF_DEFAULT_COMMAND="rg --hidden --files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# per-app settings
export PYTHONSTARTUP=~/.pyrc
export COMPOSE_DOCKER_CLI_BUILD=1
export GPG_TTY="$( tty )"
export BORG_PASSCOMMAND='pass show me/borg'

task
# }}}

# vim: fdm=marker
