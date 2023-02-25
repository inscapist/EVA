# Everything kernel related

## Linux Kernel on NixOS
https://nixos.wiki/wiki/Linux_kernel

## The hunt for kernel modules and drivers
- https://serverfault.com/questions/13991/howdo-i-tell-which-kernel-modules-are-required
- https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
- https://github.com/gytis-ivaskevicius/nixfiles/issues/19
```
lspci
inxi -Fxxxz
inxi --recommends
```
