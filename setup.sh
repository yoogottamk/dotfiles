#!/bin/bash

# Packs / unpacks the config files
# Pack:
#   link the files in this repo to the ones on the system
# Unpack:
#   link the files in the system to the ones in this repo

USAGE=$( cat <<-EOF
Usage: $0 [pack|unpack]
EOF
)

[[ "$#" != 1 ]] && { echo "$USAGE"; exit 1; }

if [[ "$1" == "pack" ]]; then
    echo Linking config...
    cd config
    for d in *; do
        cd "$d"
        for f in *; do
            ln -f "$HOME/.config/$d/$f"
        done
        cd ..
    done
    cd ..

    echo Linking scripts...
    cd scripts
    for f in *; do
        ln -f "$HOME/bin/$f"
    done
    cd ..

    # This includes hidden files in *
    shopt -s dotglob

    echo Linking .files...
    cd .files
    for f in *; do
        ln -f "$HOME/$f"
    done
    cd ..

    shopt -u dotglob

elif [[ "$1" == "unpack" ]]; then
    echo Unpacking config...
    cp -rv ./config/* "$HOME"/.config/

    echo Unpacking .files...
    cp -rv ./.files/* "$HOME"/

    echo Unpacking scripts...
    [[ -d "$HOME"/bin ]] || { mkdir "$HOME"/bin; }
    cp -rv ./scripts/* "$HOME"/bin/
    chmod +x "$HOME"/bin/*
else
    echo "$USAGE"
    exit 1
fi
