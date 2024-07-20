#!/bin/bash

source "install-scripts/global_functions.sh"

echo "Installing Hyprland and SDDM with Wayland support..."
sudo pacman -S --noconfirm sddm pavucontrol hyprland wayland waybar qt5-wayland qt6-wayland rofi-wayland hyprpaper hyprlock hypridle dunst thunar 
sudo pacman -S --noconfirm xdg-desktop-portal-hyprland gtk4 libadwaita jq polkit-kde-agent brightnessctl pamixer cliphist
yay --noconfirm -S wlogout swww hyprpicker grimblast

# Enable SDDM service
sudo systemctl enable sddm.service

# Configure SDDM to use Wayland
echo "Configuring SDDM to use Wayland..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/10-wayland.conf > /dev/null << EOL
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_DISABLE_WINDOWDECORATION=1,QT_QPA_PLATFORM=wayland
EOL

echo "SDDM configured to use Wayland."

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
