# remove greeting
set -g fish_greeting

# theme
fish_config theme choose 'ayu Mirage'

# prompt
starship init fish | source

# load aliases
source ~/.aliases

fzf_key_bindings

function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

# chpwd hook
function auto_env_venv --on-variable PWD --description \
"source .env or activate python venv in current directory"
    [ -f .env ] && source .env
    [ -d venv ] && source venv/bin/activate.fish
end

# per-app settings
set -Ux PYTHONSTARTUP ~/.pyrc
set -Ux COMPOSE_DOCKER_CLI_BUILD 1
set -Ux GPG_TTY "$( tty )"
set -Ux BORG_PASSCOMMAND 'pass show me/borg'
