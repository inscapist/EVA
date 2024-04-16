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

  security.pam.services.i3lock = {
    text = ''
      auth include login
    '';
  };
  security.polkit.enable = true;

  programs.dconf.enable = true;

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:escape";

    displayManager.startx.enable = true;

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
