#!/bin/bash

source "install-scripts/global_functions.sh"

echo "Installing Hyprland..."
sudo pacman -S --noconfirm pavucontrol hyprland wayland waybar qt5-wayland qt6-wayland hyprpaper hyprlock hypridle dunst
# sudo pacman -S --noconfirm xdg-desktop-portal-hyprland gtk4
# yay --noconfirm -S wlogout swww hyprpicker grimblast
yay --noconfirm -S wlogout

# Enable SDDM service
# sudo systemctl enable sddm.service

# Configure SDDM to use Wayland
# echo "Configuring SDDM to use Wayland..."
# sudo mkdir -p /etc/sddm.conf.d
# sudo tee /etc/sddm.conf.d/10-wayland.conf > /dev/null << EOL
# [General]
# DisplayServer=wayland
# GreeterEnvironment=QT_WAYLAND_DISABLE_WINDOWDECORATION=1,QT_QPA_PLATFORM=wayland
# EOL

# echo "SDDM configured to use Wayland."

# Stow additional GUI configs
GUI_CONFIG_DIRS=(
    "hypr"
    "waybar"
    # "rofi"
    # "dunst"
    # "ml4w"
    "wlogout"
)

for dir in "${GUI_CONFIG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        safe_stow "$dir" ~/.config
    else
        echo "Directory $dir not found, skipping..."
    fi
done

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
