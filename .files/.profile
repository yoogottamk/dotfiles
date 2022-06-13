#!/bin/bash

# setup path
source "${HOME}/.path_dirs"

# Use GTK themes for Qt apps
export GTK_THEME=vimix-dark
export QT_QPA_PLATFORMTHEME=gtk2

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
export ANDROID_SDK_ROOT="/opt/android-sdk"
export CHROME_EXECUTABLE=google-chrome-stable

# disable log4j lookups globally
export LOG4J_FORMAT_MSG_NO_LOOKUPS=true

# QT apps UI too small
export QT_SCALE_FACTOR=1.25

# use wayland wherever possible
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland

export XDG_CURRENT_DESKTOP=sway

export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1

export _JAVA_AWT_WM_NONREPARENTING=1

current_tty=$(tty)
if [[ $current_tty =~ /dev/tty* ]]; then
    # start ssh-agent
    eval $( ssh-agent )
    ssh-add

    [[ $current_tty == /dev/tty1 ]] && WLR_DRM_DEVICES=/dev/dri/card0 sway
    [[ $current_tty == /dev/tty2 ]] && Hyprland
fi
