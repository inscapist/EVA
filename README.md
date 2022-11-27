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
