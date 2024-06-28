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
stations wlan0 scan
```
List all wifi networks:
```
stations wlan0 get-networks
```
Connect to the network (where Network Name is wifi network name we want to connect):
```
stations wlan0 connect "Network Name"
```

### Use Arch Linux install

- Archinstall language: English (100%)
- Mirrors: United States
- Disk configuration: use best-effort default, btrfs, Y to use subvolumes, Use compression
- Bootloader: Grub
- Swap: True (zram)
- Hotname: arch
- Root Password: (secured)
- Add User: sergey, add to (sudo)
- Profile: Desktop, Hyprland, polkit. Graphics driver: All open-source, Greeter: sddm
- Audio: Pipewire
- Kernels: linux
- Network configuration: Use NetworkManager
- Timezone: Denver
- NTP: True
- Optional repositories: (none)

## chezmoi

This is a tool that manages dotfiles
