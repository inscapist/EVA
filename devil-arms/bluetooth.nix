{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ bluetuith ];

  # https://github.com/NixOS/nixpkgs/blob/nixos-22.05/nixos/modules/services/hardware/bluetooth.nix
  # https://wiki.archlinux.org/title/bluetooth
  # https://wiki.archlinux.org/title/Bluetooth_headset
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    hsphfpd.enable = false; # headset
    disabledPlugins = [
      "sap" # https://www.reddit.com/r/LineageOS/comments/hca65d/sap_bluetooth_profile_works_on_stock_rom_but_not/
    ];
    settings = {
      General = {
        FastConnectable = "true";
        JustWorksRepairing = "always";
      };
    };
  };
}
