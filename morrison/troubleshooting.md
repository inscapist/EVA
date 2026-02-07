# Troubleshooting

## If you can't boot..
1. boot back into the installer
2. `cryptsetup luksOpen /dev/nvme0n1p2 nixcontainer`
3. `sudo mount /dev/vg/nixos /mnt`
4. run sudo nixos-enter to chroot into the system in /mnt
5. journalctl -b to see the log of the last boot, if no entries,
6. journalctl --file /var/log/journal/$(cat /etc/machine-id)/system.journal

## Steam/Proton: high CPU (e.g. Nine Sols)
Most often this is just uncapped FPS (especially menus) -> CPU/GPU will render as fast as possible.

- Confirm the culprit: run `htop` and check whether it is the game (`NineSols.exe`), `steamwebhelper`, or `Xorg`.
- Add an FPS cap (Steam -> game -> Properties -> Launch Options):
  - Simple cap (DXVK/VKD3D): `DXVK_FRAME_RATE=60 VKD3D_FRAME_RATE=60 gamemoderun %command%`
  - Cap + gamescope: `gamemoderun steam-fpscap 60 gamescope -f -w 2560 -h 1440 -r 60 -- %command%`
- Verify it worked: prepend `mangohud --dlsym` (or use GOverlay) and check FPS/frametime.
