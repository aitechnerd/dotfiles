#!/bin/bash

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
fi

source "install-scripts/global_functions.sh"

echo "Installing Hyprland..."

# Path to .zshrc file
ZSHRC="$HOME/.zshrc"

# Hyprland autostart code
AUTOSTART_CODE='
# Autostart Hyprland on TTY1
if [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi
'

# Check if the autostart code is already in .zshrc
if grep -q "Autostart Hyprland on TTY1" "$ZSHRC"; then
    echo "Hyprland autostart code already exists in $ZSHRC"
    exit 0
fi

# Add the autostart code to .zshrc
echo "$AUTOSTART_CODE" >> "$ZSHRC"

echo "Hyprland autostart code has been added to $ZSHRC"

echo "alias ml4w-hyprland='~/.config/ml4w/apps/ML4W_Hyprland_Settings-x86_64.AppImage'" >> "$ZSHRC"

yay --noconfirm -S wlogout brave-bin outlook-for-linux-bin teams-for-linux localsend-bin
