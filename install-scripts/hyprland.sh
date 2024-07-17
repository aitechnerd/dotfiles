#!/bin/bash

source "install-scripts/global_functions.sh"

echo "Installing Hyprland and SDDM with Wayland support..."
sudo pacman -S --noconfirm pavucontrol hyprland wayland waybar qt5-wayland qt6-wayland rofi-wayland hyprpaper hyprlock dunst thunar xdg-desktop-portal-hyprland gtk4 libadwaita jq
yay --noconfirm -S wlogout

# Enable SDDM service
# sudo systemctl enable sddm.service

# Configure SDDM to use Wayland using Augeas
#echo "Configuring SDDM to use Wayland..."
#sudo augtool -s <<EOF
#set /files/etc/sddm.conf/General/DisplayServer wayland
#set /files/etc/sddm.conf/General/GreeterEnvironment "QT_WAYLAND_DISABLE_WINDOWDECORATION=1,QT_QPA_PLATFORM=wayland"
#save
#EOF

# Install Catppuccin theme for Hyprland
echo "Installing Catppuccin theme for Hyprland..."
    
# Stow additional GUI configs
GUI_CONFIG_DIRS=(
    "hypr"
    "waybar"
    "rofi"
    "dunst"
    "ml4w"
    "wlogout"
)

for dir in "${GUI_CONFIG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        safe_stow "$dir" ~/.config
    else
        echo "Directory $dir not found, skipping..."
    fi
done
