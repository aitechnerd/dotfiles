#!/bin/bash

source "install-scripts/global_functions.sh"

echo "Installing basic utilities and console tools..."
sudo pacman -S --noconfirm git base-devel wget unzip stow gum rsync figlet zsh tmux neovim reflector mc dhcpcd neofetch fastfetch fuse2 alacritty nmtui
sudo pacman -S --noconfirm ttf-dejavu-nerd ttf-font-awesome ttf-fira-sans ttf-fira-code ttf-firacode-nerd

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

# Set up Reflector
echo "Setting up Reflector for mirror list management..."
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Create Reflector systemd service
echo "Creating Reflector systemd service..."
sudo tee /etc/systemd/system/reflector.service > /dev/null << EOL
[Unit]
Description=Pacman mirrorlist update
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/bin/reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

[Install]
RequiredBy=multi-user.target
EOL

# Create Reflector systemd timer
echo "Creating Reflector systemd timer..."
sudo tee /etc/systemd/system/reflector.timer > /dev/null << EOL
[Unit]
Description=Run reflector weekly

[Timer]
OnCalendar=Mon *-*-* 4:00:00
RandomizedDelaySec=15m
Persistent=true

[Install]
WantedBy=timers.target
EOL

# Enable and start Reflector timer
sudo systemctl enable reflector.timer
sudo systemctl start reflector.timer

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