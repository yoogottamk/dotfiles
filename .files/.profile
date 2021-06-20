#!/bin/bash

source ~/.path_dirs

# Use GTK themes for Qt apps
export QT_QPA_PLATFORMTHEME="gtk2"

export EDITOR=nvim
export VISUAL=nvim

export TERMINAL=tilix

# start the transparency compositor
picom -b

# nvm
export NVM_DIR="$HOME/.nvm"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export ANDROID_SDK_ROOT="/opt/android-sdk"

export CHROME_EXECUTABLE=google-chrome-stable
