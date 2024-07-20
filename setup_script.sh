#!/bin/bash

# Exit on any error
set -e

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
fi

source "install-scripts/global_functions.sh"

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Ensuring all in the scripts folder are made executable
chmod +x install-scripts/*
sleep 1

if ask_yes_no "Install basic utilities and console tools?"; then
    # Install basic utilities and console tools
    ./install-scripts/console.sh
    sleep 1
    ./install-scripts/pacman.sh
    sleep 1
    ./install-scripts/wifi.sh
    sleep 1
    ./install-scripts/bluetooth.sh
    sleep 1
fi

# Ask about graphical interface
if ask_yes_no "Do you want to install Hyprland window manager?"; then
    ./install-scripts/hyprland.sh
    sleep 1
fi

# Ask about graphical interface
if ask_yes_no "Do you want to install office and development tools?"; then
    ./install-scripts/office.sh
    sleep 1
fi

echo "Setup complete! Please log out and log back in to start using Zsh. Then reboot your system to apply all changes."