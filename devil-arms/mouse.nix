{ pkgs, user, ... }:
{
  # Razer/OpenRazer + Polychromatic GUI
  hardware.openrazer.enable = true;
  # Allow the main user to access the daemon/device via the right group
  hardware.openrazer.users = [ user ];

  environment.systemPackages = with pkgs; [
    polychromatic
    usbutils # provides `lsusb`
  ];
}
