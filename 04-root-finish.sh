#!/bin/bash

# Update system
echo "Updating system..."
pacman -S --noconfirm bluez bluez-utils yazi dhcpcd fastfetch mc fuse2 networkmanager pipewire wireplumber ttf-font-awesome ttf-jetbrains-mono ttf-fira-sans ttf-firacode-nerd jq ttf-meslo-nerd htop
pacman -S --noconfirm pavucontrol alacritty kitty hyprland wayland waybar rofi-wayland qt5-wayland qt6-wayland hyprpaper hyprlock hypridle dunst thunar xdg-desktop-portal-hyprland gtk4 libadwaita python-gobject grim slurp
pacman -S --noconfirm firefox code jre21-openjdk dbeaver vulkan-radeon gnome-keyring bitwarden telegram-desktop

systemctl enable bluetooth.service
systemctl start bluetooth.service