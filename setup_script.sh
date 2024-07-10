#!/bin/bash

# Exit on any error
set -e

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
fi

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Function to ask yes/no questions
ask_yes_no() {
    while true; do
        read -p "$1 (y/n): " choice
        case "$choice" in 
            y|Y ) return 0;;
            n|N ) return 1;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Function to safely stow a directory
safe_stow() {
    local dir=$1
    local target=$2
    echo "Stowing $dir..."
    
    # Check for conflicts
    conflicts=$(stow -n -v -t "$target" "$dir" 2>&1 | grep -c "BUG IN STOW") || true
    
    if [ "$conflicts" -gt 0 ]; then
        echo "Conflicts found in $dir. Backing up and replacing..."
        for file in $(stow -n -v -t "$target" "$dir" 2>&1 | grep "BUG IN STOW" | awk '{print $NF}'); do
            mv "$target/$file" "$target/$file.backup"
        done
    fi
    
    stow -v -R -t "$target" "$dir"
}

# Ensuring all in the scripts folder are made executable
chmod +x install-scripts/*
sleep 1

if ask_yes_no "Install basic utilities and console tools? y/n"; then
    # Install basic utilities and console tools
    ./install-script/console.sh
    sleep 1
    ./install-script/pacman.sh
    sleep 1
fi

# Ask about graphical interface
if ask_yes_no "Do you want to install Hyprland window manager with SDDM?"; then
    ./install-script/hyprland.sh
    sleep 1
fi
exit


echo "Setup complete! Please log out and log back in to start using Zsh. Then reboot your system to apply all changes."