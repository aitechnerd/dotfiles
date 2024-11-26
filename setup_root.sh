#!/bin/bash

source "install-scripts/global_functions.sh"

echo -e "${NOTE} Adding Extra Spice in pacman.conf ... ${RESET}" 2>&1 | tee -a "$LOG"
pacman_conf="/etc/pacman.conf"

# Remove comments '#' from specific lines
lines_to_edit=(
    "Color"
    "CheckSpace"
    "VerbosePkgLists"
    "ParallelDownloads"
)

# Uncomment specified lines if they are commented out
for line in "${lines_to_edit[@]}"; do
    if grep -q "^#$line" "$pacman_conf"; then
        sudo sed -i "s/^#$line/$line/" "$pacman_conf"
        echo -e "${CAT} Uncommented: $line ${RESET}" 2>&1 | tee -a "$LOG"
    else
        echo -e "${CAT} $line is already uncommented. ${RESET}" 2>&1 | tee -a "$LOG"
    fi
done

# Add "ILoveCandy" below ParallelDownloads if it doesn't exist
if grep -q "^ParallelDownloads" "$pacman_conf" && ! grep -q "^ILoveCandy" "$pacman_conf"; then
    sudo sed -i "/^ParallelDownloads/a ILoveCandy" "$pacman_conf"
    echo -e "${CAT} Added ILoveCandy below ParallelDownloads. ${RESET}" 2>&1 | tee -a "$LOG"
else
    echo -e "${CAT} ILoveCandy already exists ${RESET}" 2>&1 | tee -a "$LOG"
fi

echo -e "${CAT} Pacman.conf spicing up completed ${RESET}" 2>&1 | tee -a "$LOG"

### Disable wifi powersave mode ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
echo -e "The following has been added to $LOC.\n"
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
echo -e "\n"
echo -e "Restarting NetworkManager service...\n"
sudo systemctl restart NetworkManager
sleep 1

systemctl enable NetworkManager.service
systemctl start NetworkManager.service

# Update system
echo "Updating system..."
pacman -Syu --noconfirm
pacman -S --noconfirm bluez bluez-utils git base-devel wget tar unzip rsync stow zsh tmux neovim mc yazi dhcpcd fastfetch fuse2 networkmanager pipewire wireplumber ttf-font-awesome ttf-jetbrains-mono ttf-fira-sans ttf-firacode-nerd jq ttf-meslo-nerd htop
pacman -S --noconfirm pavucontrol alacritty kitty hyprland wayland waybar rofi-wayland qt5-wayland qt6-wayland hyprpaper hyprlock hypridle dunst thunar xdg-desktop-portal-hyprland gtk4 libadwaita python-gobject grim slurp
pacman -S --noconfirm firefox code jre21-openjdk dbeaver vulkan-radeon gnome-keyring bitwarden telegram-desktop


