#!/bin/bash

source ~/.path_dirs

# Use GTK themes for Qt apps
export GTK_THEME=vimix-dark
export QT_QPA_PLATFORMTHEME="gtk2"

export EDITOR=nvim
export VISUAL=nvim

export TERMINAL=kitty

# nvm
export NVM_DIR="$HOME/.nvm"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export ANDROID_SDK_ROOT="/opt/android-sdk"

export CHROME_EXECUTABLE=google-chrome-stable

export LOG4J_FORMAT_MSG_NO_LOOKUPS=true

eval `ssh-agent`
ssh-add

if [ $(tty) = "/dev/tty2" ]; then
    startx
elif [ $(tty) = "/dev/tty1" ]; then
    # use wayland wherever possible

    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    # export GDK_BACKEND=wayland
    export CLUTTER_BACKEND=wayland
    export SDL_VIDEODRIVER=wayland

    export XDG_CURRENT_DESKTOP=sway

    export MOZ_ENABLE_WAYLAND=1
    export MOZ_DBUS_REMOTE=1

    export _JAVA_AWT_WM_NONREPARENTING=1

    sway
fi
