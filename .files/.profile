#!/bin/bash

source ~/.path_dirs

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Use GTK themes for Qt apps
export QT_QPA_PLATFORMTHEME="gtk2"

export EDITOR=nvim
export VISUAL=nvim

# start the transparency compositor
compton &
