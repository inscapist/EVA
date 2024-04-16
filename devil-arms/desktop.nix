{ pkgs, ... }:
{

  hardware.opengl.enable = true;
  fonts.enableDefaultPackages = true;

  xdg.mime.enable = true;

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  services.displayManager.defaultSession = "none+i3";

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:escape";

    # NOTE mutually exclusive with `services.displayManager.defaultSession`
    # displayManager.startx.enable = true;

    # run autostart programs
    desktopManager.runXdgAutostartIfNone = true;

    # use i3
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3lock-fancy-rapid
        xss-lock
      ];
    };
  };
}
