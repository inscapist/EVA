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
  services.gvfs.enable = true;
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

  # https://github.com/NixOS/nixpkgs/issues/34603
  # https://wiki.archlinux.org/title/HiDPI
  services.xserver.dpi = 168; # bigger value -> larger elements
  services.xserver.upscaleDefaultCursor = false;
  environment.variables = {
    # the following 2 variables work in conjunction with each other,
    # GDK_SCALE allows doubling/tripling resolution (integer), 
    # while GDK_DPI_SCALE controls the text size (float)
    GDK_SCALE = "2"; # doubles resolution
    GDK_DPI_SCALE = "0.4"; # scales down text
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2.2";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    XCURSOR_SIZE = "32";
  };
}
