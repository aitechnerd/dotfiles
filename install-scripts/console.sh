#!/bin/bash

source "install-scripts/global_functions.sh"

git config --global user.name "Sergey Belov"
git config --global user.email "belov.ss@gmail.com"


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
    "tmux"
    "btop"
)

for dir in "${CONFIG_STOW_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        safe_stow "$dir" ~/
    else
        echo "Directory $dir not found, skipping..."
    fi
done

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