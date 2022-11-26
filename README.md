# EVA

My NixOs configuration

## What's with all these weird naming?

They are inspired by the DMC game.

1. Nephilims -> Systems
2. Devil Arms -> NixOS modules
4. Devil Breakers -> HomeManager modules
3. Devil Triggers -> enhancements/utils

## New machine setup

Choose your own passphrase below:

```sh
# === config starts ===
passphrase="SAY SOMETHING"
diskdev=/dev/nvme0n1 # check with lsblk
bootpart=/dev/nvme0n1p1 # check with lsblk 
rootpart=/dev/nvme0n1p2 # check with lsblk

# === LVM on LUKS2 starts ===
# partition disk to the standard "EFI:Linux" layout
sgdisk -o -g -n 1::+550M -t 1:ef00 -n 2:: -t 2:8300 $diskdev

# format partition into a LUKS container
echo $passphrase | cryptsetup luksFormat $rootpart --type luks2

# open/unlock the LUKS container to /dev/mapper/nixcontainer
echo $passphrase | cryptsetup luksOpen $rootpart nixcontainer

# initialize physical volume, "nixcontainer"
pvcreate /dev/mapper/nixcontainer

# create volume group named "vg" at /dev/vg
vgcreate vg /dev/mapper/nixcontainer

# create a logical volume named "nixos" at /dev/vg/nixos
lvcreate -l '100%FREE' -n nixos vg

mkfs.fat $bootpart
mkfs.ext4 -L nixos /dev/vg/nixos

# === mount for installation ===
mount /dev/vg/nixos /mnt
mkdir /mnt/boot
mount $bootpart /mnt/boot

# === actual installation ===
nixos-generate-config --root /mnt

# NOW, cd into /mnt/etc/nixos/ and make changes
cd /mnt/etc/nixos/
sudo nixos-install
```
