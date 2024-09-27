Check harddrives: `lsblk`

Create three partitions: 1G for EFI, RAM size in GB for swap and rest for as main partition
```
sudo su
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
export PS1="(chroot) ${PS1}" && \
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
Uncomment US UTF-8

`locale-gen`

`eselect locale list`

`eselect locale set 4` (select en_US.utf8)

`env-update && source /etc/profile && export PS1="(chroot) ${PS1}"`
