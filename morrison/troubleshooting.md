# Troubleshooting

## If you can't boot..
1. boot back into the installer
2. `cryptsetup luksOpen /dev/nvme0n1p2 nixcontainer`
3. `sudo mount /dev/vg/nixos /mnt`
4. run sudo nixos-enter to chroot into the system in /mnt
5. journalctl -b to see the log of the last boot, if no entries,
6. journalctl --file /var/log/journal/$(cat /etc/machine-id)/system.journal
