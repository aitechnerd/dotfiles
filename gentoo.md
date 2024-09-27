Check harddrives: `lsblk`

Create three partitions: 1G for EFI, RAM size in GB for swap and rest for as main partition
```
sudo su && \
cfdisk /dev/nvme0n1
```

Create boot partition of 1G, swap, main btrfs

```
mkfs.vfat -F 32 /dev/nvme0n1p1 && \
mkswap /dev/nvme0n1p2 && \
swapon /dev/nvme0n1p2 && \
mkfs.btrfs -f /dev/nvme0n1p3 && \
mkdir --parents /mnt/gentoo && \
mount /dev/nvme0n1p3 /mnt/gentoo && \
cd /mnt/gentoo && \
btrfs subvolume create @ && \
btrfs subvolume create @home && \
btrfs subvolume create @log && \
cd && \
umount /mnt/gentoo && \
mount -o subvol=@ /dev/nvme0n1p3 /mnt/gentoo/ && \
mkdir --parents /mnt/gentoo/home && \
mount -o subvol=@home /dev/nvme0n1p3 /mnt/gentoo/home && \
mkdir --parents /mnt/gentoo/var/log && \
mount -o subvol=@log /dev/nvme0n1p3 /mnt/gentoo/var/log && \
mkdir --parents /mnt/gentoo/efi && \
mount /dev/nvme0n1p1 /mnt/gentoo/efi && \
cd /mnt/gentoo
```

https://www.gentoo.org/downloads/

Download Stage 3 systemd

Unpack it:
`tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner`

**TODO: add comman to copy make.conf file or use stow**

```
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && \
mount --types proc /proc /mnt/gentoo/proc && \
mount --rbind /sys /mnt/gentoo/sys && \
mount --make-rslave /mnt/gentoo/sys && \
mount --rbind /dev /mnt/gentoo/dev && \
mount --make-rslave /mnt/gentoo/dev && \
mount --bind /run /mnt/gentoo/run && \
mount --make-slave /mnt/gentoo/run && \
chroot /mnt/gentoo /bin/bash && \
source /etc/profile && \
export PS1="(chroot) ${PS1}"
```

```
emerge-webrsync && \
eselect profile list
```
Choose profile: `eselect profile set 24` (select desktop with systemd)

```
emerge --ask --oneshot app-portage/cpuid2cpuflags && \
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags && \
emerge --ask --verbose --update --deep --newuse @world
```

Install timezone:
`ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime`

nano /etc/locale.gen
Uncomment en_US.UTF-8 UTF-8

`locale-gen`

`eselect locale list`

`eselect locale set 4` (select en_US.utf8)

`env-update && source /etc/profile && export PS1="(chroot) ${PS1}"`

```
emerge --ask sys-kernel/linux-firmware
emerge --ask sys-kernel/installkernel
USE="dracut" emerge --ask sys-kernel/gentoo-kernel-bin
emerge --depclean
echo "gentoo" > /etc/hostname
```

`nano /etc/fstab`

```
/dev/nvme0n1p1          /boot           vfat            defaults        0 2
/dev/nvme0n1p2          none            swap            sw              0 0
/dev/nvme0n1p3          /               ext4            defaults,noatime        0 1
```

Set secured root password `passwd`

```
systemd-machine-id-setup
systemd-firstboot --prompt
systemctl preset-all --preset-mode=enable-only
emerge --ask sys-apps/mlocate
systemctl enable sshd
systemctl enable getty@tty1.service
emerge --ask app-shells/bash-completion
emerge --ask net-misc/chrony
systemctl enable chronyd.service
systemctl enable systemd-timesyncd.service
emerge --ask sys-block/io-scheduler-udev-rules
emerge --ask sys-fs/dosfstools sys-fs/btrfs-progs
emerge --ask net-misc/networkmanager
```

Add user: `useradd -mG wheel,audio,video,disk {username}`
Add user to a group: `gpasswd -a {username} plugdev`
Set user password: `passwd {username}`

```
systemctl enable NetworkManager
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge --ask sys-boot/grub
grub-install --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg
exit
```

Rebooting

```
cd && \
umount -l /mnt/gentoo/dev{/shm,/pts,} && \
umount -R /mnt/gentoo && \
reboot
```

After reboot login under root

```
emerge --ask pipewire wireplumber rtkit
systemctl enable dbus
emerge --ask gui-wm/hyprland
emerge --ask app-misc/brightnessctl
emerge --ask media-sound/playerctl
emerge --ask gui-libs/xdg-desktop-portal-hyprland
```

Make.conf

```
# These settings were set by the catalyst build script that automatically
# built this stage.
# Please consult /usr/share/portage/config/make.conf.example for a more
# detailed example.
COMMON_FLAGS="-O2 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"
MAKEOPTS="-j6 -l7"

VIDEO_CARDS="amdgpu radeonsi radeon"
ACCEPT_LICENSE="*"

USE="networkmanager iwd wayland X pipewire dracut"

# NOTE: This stage was built with the bindist USE flag enabled

# This sets the language of build output to English.
# Please keep this setting intact when reporting bugs.
LC_MESSAGES=C.utf8
GRUB_PLATFORMS="efi-64"
```

