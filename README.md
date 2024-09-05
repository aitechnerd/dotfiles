# Dotfiles and installation scripts

## Arch Linux Installation

### Connect to Wifi network
https://wiki.archlinux.org/title/iwd

Run the wifi app:
```
iwctl
```
Get list of wifi devices:
```
device list
```
Activate networks scan:
```
station wlan0 scan
```
List all wifi networks:
```
station wlan0 get-networks
```
Connect to the network (where Network Name is wifi network name we want to connect):
```
station wlan0 connect "Network Name"
```

### Use Arch Linux install (v.2.8.1)


- Archinstall language: English (100%)
- Mirrors: United States
- Disk configuration: Partitioning, Use a best-effort default partition layout, btrfs, Y to use subvolumes, Use compression
- Bootloader: Grub
- Swap: True (zram)
- Hotname: archbtw
- Root Password: (secured)
- Add User: sergey, add to (sudo)
- Profile: Minimal
- Audio: Pipewire
- Kernels: linux
- Network configuration: Use NetworkManager
- Timezone: Denver
- Automatic time sync (NTP): True
- Optional repositories: (none)

## Installation

```
curl -L https://gist.githubusercontent.com/aitechnerd/f949ef875f2afd3f7490a6cd985f5075/raw/44b1c919c52292650fe767993446bdcddaa601d0/bootstrap.sh | bash
```
```
curl -L https://shorturl.at/VLGKy | bash
```

bluetoothctl

- scan on
- pair MAC_address

To connect Keychron keyboard:

- power on
- agent KeyboardOnly
- default-agent
- pairable on
- scan on
- pair 01:02:03:04:05:06
- trust 01:02:03:04:05:06
- connect 01:02:03:04:05:06
- quit

```
# Autostart Hyprland on TTY1
if [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi

alias ml4w-hyprland='~/.config/ml4w/apps/ML4W_Hyprland_Settings-x86_64.AppImage'
```

```
alacritty 0.13.2-2
amd-ucode 20240809.59460076-1
base 3-2
base-devel 1-1
bitwarden 2024.8.1-1
bluez 5.77-1
bluez-utils 5.77-1
brave-bin 1:1.69.162-1
btop 1.3.2-1
btrfs-progs 6.10.1-2
code 1.92.1-1
dbeaver 24.2.0-1
dhcpcd 10.0.10-1
dunst 1.11.0-1
efibootmgr 18-3
fastfetch 2.23.0-1
firefox 130.0-1
firefox-pwa-bin 2.12.1-1
foot 1.18.1-1
fuse2 2.9.9-5
git 2.46.0-2
gnome-keyring 1:46.2-1
grim 1.4.1-2
grub 2:2.12-2
gst-plugin-pipewire 1:1.2.3-1
gtk4 1:4.14.5-1
htop 3.3.0-3
hypridle 0.1.2-1
hyprland 0.42.0-2
hyprlock 0.4.1-1
hyprpaper 0.7.1-1
jq 1.7.1-2
jre21-openjdk 21.0.4.u7-1
kitty 0.36.1-1
libadwaita 1:1.5.3-1
libpulse 17.0-3
linux 6.10.8.arch1-1
linux-firmware 20240809.59460076-1
localsend-bin 1.15.4-1
mc 4.8.32-1
mesa-vdpau 1:24.2.1-1
mission-center 0.5.2-1
neovim 0.10.1-3
networkmanager 1.48.10-1
outlook-for-linux-bin 1.3.13-1
pavucontrol 1:6.1-1
pipewire 1:1.2.3-1
pipewire-alsa 1:1.2.3-1
pipewire-jack 1:1.2.3-1
pipewire-pulse 1:1.2.3-1
python-gobject 3.48.2-2
qt5-wayland 5.15.15+kde+r59-1
qt6-wayland 6.7.2-4
rofi-wayland 1.7.5+wayland3-2
rsync 3.3.0-2
slack-desktop 4.39.95-1
slurp 1.5.0-1
sof-firmware 2024.06-1
stow 2.4.0-1
teams-for-linux 1.9.6-1
telegram-desktop-bin 5.4.1-1
thunar 4.18.11-1
timeshift 24.06.3-1
tmux 3.4-10
ttf-fira-sans 1:4.301-2
ttf-firacode-nerd 3.2.1-2
ttf-font-awesome 6.6.0-1
ttf-jetbrains-mono 2.304-2
ttf-meslo-nerd 3.2.1-2
ttf-nerd-fonts-symbols-mono 3.2.1-1
unzip 6.0-21
vulkan-radeon 1:24.2.1-1
waybar 0.10.4-2
wget 1.24.5-3
wireplumber 0.5.5-1
wlogout 1.2.2-0
xdg-desktop-portal-hyprland 1.3.3-2
yay 12.3.5-1
yay-debug 12.3.5-1
yazi 0.3.2-1
zen-browser-bin 1.0.0.a.35-1
zram-generator 1.1.2-1
zsh 5.9-5
```