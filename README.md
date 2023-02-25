# EVA

My NixOS configuration

## What's with all these hippy naming?

Inspired by the DMC game series.

1. Nephilims -> Systems
2. Devil Arms -> NixOS modules
3. Devil Breakers -> HomeManager modules
4. Devil Triggers -> enhancements/utils/themes
4. Nico -> copied code that I don't understand :)
4. Morrison -> documentation

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
6. run `party` and `flaky`. 
7. go take a nap. It is gonna take awhile.


## Setting up a new machine
1. update this flake according to the generated config from `nixos-generate-config --root /mnt`.
2. run `flaky`.


##  Credits
I learned alot (and also copied 😅) from the community.

🙇 @fufexan

🙇 @ruixi

🙇 @hlissner


