#!/bin/bash

source "install-scripts/global_functions.sh"

echo "Installing basic utilities and console tools..."
sudo pacman -S --noconfirm git base-devel wget tar unzip stow zsh tmux neovim mc dhcpcd neofetch fastfetch fuse2 alacritty networkmanager pipewire wireplumber
sudo pacman -S --noconfirm ttf-dejavu-nerd ttf-font-awesome ttf-fira-sans ttf-fira-code ttf-firacode-nerd ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono

git config --global user.name "Sergey Belov"
git config --global user.email "belov.ss@gmail.com"

# Install yay
echo "Installing yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo "yay is already installed, skipping..."
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change default shell to Zsh
echo "Changing default shell to Zsh..."
chsh -s $(which zsh)

# Stow .config directory files
CONFIG_STOW_DIRS=(
    "alacritty"
    "mc"
)

for dir in "${CONFIG_STOW_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        safe_stow "$dir" ~/.config
    else
        echo "Directory $dir not found, skipping..."
    fi
done

safe_stow "tmux" ~/

# Install Tmux Plugin Manager (TPM)
if [ -f ~/.tmux.conf ]; then
    echo "Setting up Tmux Plugin Manager..."
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    # Install tmux plugins
    echo "Installing tmux plugins..."
    ~/.tmux/plugins/tpm/bin/install_plugins
fi