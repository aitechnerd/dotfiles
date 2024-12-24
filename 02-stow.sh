#!/bin/bash

# Check if running as root. If root, script will exit

source "install-scripts/global_functions.sh"


# Stow .config directory files
CONFIG_STOW_DIRS=(
    "alacritty"
    "mc"
    "tmux"
    "btop"
    "hypr"
    "waybar"
    "rofi"
    "dunst"
    "wlogout"
)

for dir in "${CONFIG_STOW_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        safe_stow "$dir" ~/
    else
        echo "Directory $dir not found, skipping..."
    fi
done

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
