# EVA

My NixOS configuration

## What's with all these hippy naming?

Inspired by the DMC game series.

| Name                                     | Description                        |
| ---------------------------------------- | ---------------------------------- |
| [Nephilims](nephilims)                   | My systems, real or virtual.       |
| [Devil Arms](devil-arms)                 | NixOS modules                      |
| [Devil Breakers](devil-breakers)         | HomeManager modules                |
| [Devil Triggers](devil-triggers)         | Enhancements, utils, themes..      |
| [Sin Devil Triggers](sin-devil-triggers) | Modules written by someone else :) |
| [Nico](devil-triggers/nico)              | The crafty bits :)                 |
| [Morrison](morrison)                     | The Documentation                  |

## Build Installer ISO

Example for vergil:
``` sh
nix build .#nixosConfigurations.vergilInstaller.config.system.build.isoImage -o vergil-iso
find the thumbdrive using `lsblk` and replace `/dev/sdb` below
sudo dd if=vergil-iso/iso/TAB.iso of=/dev/sdb status=progress
```

## Installation
1. With the USB, enter boot selection with F12 (on dell).
2. use `nmtui` to activate wifi.
3. run `ip a` to show ip addr.
4. now you can access via ssh (this is optional, of course).
5. run `sudo su`.
6. run `party`. Enter your LUKS passphrase.
7. run `flaky`.
8. go take a nap. It is gonna take awhile.
9. reboot! 

## First boot
1. run `nmtui` to setup your wifi.
2. run `sudo passwd $USER` to change your password.
3. run `Hyprland`.

## Setting up a new machine
1. update this flake according to the generated config from `nixos-generate-config --root /mnt`.
2. run `flaky`.


##  Credits
I learned alot (and also copied 😅) from the community.

🙇 @fufexan

🙇 @ruixi

🙇 @hlissner


