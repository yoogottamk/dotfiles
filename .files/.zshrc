[[ -o login ]] && source ~/.profile

# base {{{
export ZSH="/home/yog/.oh-my-zsh"

ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
    vi-mode
    zsh-syntax-highlighting
    zsh-autosuggestions
    docker
    docker-compose
)

source $ZSH/oh-my-zsh.sh
# }}}

# zsh/plugin settings {{{
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

# automatically source venv on cd
add-zsh-hook -Uz chpwd (){ [ -f .env ] && source .env; [ -d venv ] && source venv/bin/activate }

# automatically send SIGCONT to disown'd child
setopt AUTO_CONTINUE
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
complete -F __start_kubectl k

# kitty grep
compdef _rg kg
# }}}

# misc {{{
# aliases
source ~/.aliases

# fasd
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"  >> /dev/null 2>&1

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER=';;'
export FZF_DEFAULT_COMMAND="rg --hidden --files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# per-app settings
export PYTHONSTARTUP=~/.pyrc
export LESS="-F -X $LESS"
export COMPOSE_DOCKER_CLI_BUILD=1
export GPG_TTY=`tty`
# }}}

# vim: fdm=marker
