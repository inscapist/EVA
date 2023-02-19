# EVA

My NixOs configuration

## What's with all these weird naming?

They are inspired by the DMC game.

1. Nephilims -> Systems
2. Devil Arms -> NixOS modules
3. Devil Breakers -> HomeManager modules (WIP)
4. Devil Triggers -> enhancements/utils
5. Sin Devil Triggers -> Themes (WIP)

## Build Installer ISO

``` sh
nix build .#nixosConfigurations.vergilInstaller.config.system.build.isoImage
# use `lsblk` to find the flashdrive
dd if=result/iso/_.iso of=/dev/sd_ status=progress
```

## Installation
1. With the USB, enter boot selection with F12
2. use `nmtui` to activate wifi
3. run `ip a` to show ip addr
4. run `party` and `flaky`. and ignore following steps
5. execute scripts in [gist](https://gist.github.com/sagittaros/ef15791c46e71adb934b52a3892236b7)
6. update this flake according to the generated config
7. clone this flake to /mnt/etc/...

