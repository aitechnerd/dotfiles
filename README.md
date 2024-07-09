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

## Installation

```
curl -L https://gist.githubusercontent.com/aitechnerd/f949ef875f2afd3f7490a6cd985f5075/raw/04f602995c86d9c2f6d228c28c460bcec39ca675/bootstrap.sh | bash
```

## chezmoi

This is a tool that manages dotfiles

```
pacman -S bluez bluez-utils hyprland
nmtui
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
systemctl enable bluetooth.service
systemctl start bluetooth.service
```

```
### Disable wifi powersave mode ###
read -n1 -rep 'Would you like to disable wifi powersave? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi
```
bluetoothctl

- scan on
- pair MAC_address
