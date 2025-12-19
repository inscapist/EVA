{ pkgs, ... }:
{

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
  services = {
    gvfs.enable = true;
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    displayManager.defaultSession = "none+i3";

    xserver = {
      enable = true;
      xkb.layout = "us";
      # replaced by kmonad
      #xkb.options = "caps:escape";

      # displayManager.sessionCommands = ''
      #   sleep 5 && ${pkgs.xorg.xset}/bin/xset r rate 250 66 &
      # '';

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

      # https://github.com/NixOS/nixpkgs/issues/34603
      # https://wiki.archlinux.org/title/HiDPI
      # https://ricostacruz.com/til/fractional-scaling-on-xorg-linux
      dpi = 144; # bigger value -> larger elements
      upscaleDefaultCursor = false;
    };
  };
  environment.variables = {
    # the following 2 variables work in conjunction with each other,
    # GDK_SCALE allows doubling/tripling resolution (integer), 
    # while GDK_DPI_SCALE controls the text size (float)
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2.2";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    XCURSOR_SIZE = "32";
  };

  environment.systemPackages = with pkgs; [
    xorg.xset
    xorg.setxkbmap
    xorg.xinit
    xorg.xrandr
    xorg.xrdb
    xorg.xprop
    xorg.xeyes
    xorg.xlsclients
    xorg.xwininfo
    xorg.xev
  ];
}
