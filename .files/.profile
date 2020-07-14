#!/bin/bash

source ~/.path_dirs

# Use GTK themes for Qt apps
export QT_QPA_PLATFORMTHEME="gtk2"

export EDITOR=nvim
export VISUAL=nvim

export TERMINAL=tilix

# start the transparency compositor
picom -b

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
