#!/usr/bin/env fish

# setup path
set -x PATH \
    $PATH \
    ~/bin \
    ~/.local/bin \
    ~/go/bin \
    ~/.cargo/bin \
    ~/.local/share/gem/ruby/3.0.0/bin \
    ~/.gem/ruby/3.0.0/bin

# Use GTK themes for Qt apps
set -x GTK_THEME vimix-dark
set -x QT_QPA_PLATFORMTHEME gtk2

set -x EDITOR nvim
set -x VISUAL nvim
set -x TERMINAL kitty
set -x ANDROID_SDK_ROOT /opt/android-sdk
set -x CHROME_EXECUTABLE google-chrome-stable

# disable log4j lookups globally
set -x LOG4J_FORMAT_MSG_NO_LOOKUPS true

# QT apps UI too small
set -x QT_SCALE_FACTOR 1.25

# use wayland wherever possible
set -x QT_QPA_PLATFORM wayland
set -x QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -x CLUTTER_BACKEND wayland
set -x SDL_VIDEODRIVER wayland

set -x XDG_CURRENT_DESKTOP sway

set -x MOZ_ENABLE_WAYLAND 1
set -x MOZ_DBUS_REMOTE 1

set -x _JAVA_AWT_WM_NONREPARENTING 1

set current_tty $(tty)

if string match -q '/dev/tty*' $current_tty
    # start ssh-agent
    eval (ssh-agent -c) > /dev/null
    set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -x SSH_AGENT_PID $SSH_AGENT_PID
    set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK

    ssh-add

    [ $current_tty = /dev/tty1 ] && WLR_DRM_DEVICES=/dev/dri/card0 sway
    [ $current_tty = /dev/tty2 ] && Hyprland
end
