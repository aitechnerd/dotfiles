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
curl -L https://gist.githubusercontent.com/aitechnerd/f949ef875f2afd3f7490a6cd985f5075/raw/04f602995c86d9c2f6d228c28c460bcec39ca675/bootstrap.sh | bash
```
```
curl -L https://shorturl.at/B5FSY | bash
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
