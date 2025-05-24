#!/usr/bin/env bash

# Script used to repair the nix configuration after a macos update

# Check if nix is not installed
if ! [ -x "$(command -v nix)" ]; then
    # Make sure the script is ran as sudo
    if [[ $EUID -ne 0 ]]; then
        exec sudo "$0" "$@"
    fi
    echo "# Nix" >> /etc/zshrc
    echo "if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then" >> /etc/zshrc
    echo "  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'" >> /etc/zshrc
    echo "fi" >> /etc/zshrc
    echo "# End Nix" >> /etc/zshrc

    echo "Success: Nix and Home Manager restored."
    echo "    Please restart your terminal."
else
    echo "Error: Nix is already installed."
fi

