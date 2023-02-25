# Installer

## Enable Wifi
```
# https://nixos.org/manual/nixos/stable/index.html#sec-wireless
$ wpa_passphrase ESSID PSK > /etc/wpa_supplicant.conf
$ systemctl restart wpa_supplicant
```

or
```
$ sudo systemctl start wpa_supplicant
$ wpa_cli

> add_network
0
> set_network 0 ssid "myhomenetwork"
OK
> set_network 0 psk "mypassword"
OK
> set_network 0 key_mgmt WPA-PSK
OK
> enable_network 0
OK
> quit
```

## Enable SSH
```
passwd
ip a # to find ip address
```

## Install helpers
A million ways

```
nix-shell -p git neovim
```

```
nix-env -iA nixos.pkgs.gitAndTools.gitFull
```

```
$ nix repl "<nixpkgs>"
# inside repl
:i neovim
:i (pkgs.emacsPackagesGen pkgs.emacs-nox).emacsWithPackages (f: [f.melpaPackages.nix-mode])
```

## Turn installer to nix

https://gist.github.com/infinisil/e36eb6ef599d94876a0ce1a13fad56b0
