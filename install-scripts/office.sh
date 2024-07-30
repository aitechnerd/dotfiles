#!/bin/bash

source "install-scripts/global_functions.sh"

yay --noconfirm -S brave-bin outlook-for-linux-bin teams-for-linux

sudo pacman -S --noconfirm firefox code jre21-openjdk dbeaver vulkan-radeon gnome-keyring bitwarden
