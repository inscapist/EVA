{ pkgs, ... }: {

  hardware.opengl.enable = true;
  fonts.enableDefaultPackages = true;

  xdg.portal = {
    enable = true;
    config = { common = { default = [ "gtk" ]; }; };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security.pam.services.i3lock = {
    text = ''
      auth include login
    '';
  };
  security.polkit.enable = true;

  programs = { dconf.enable = true; };

  services.xserver = {
    enable = true;
    autorun = false;
    xkb.layout = "us";

    # A misleading option. Has nought to do with startx
    # it simply means do not enable any display
    displayManager = {
      startx.enable = true;
    };

    # use i3
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ i3lock ];
    };
  };
}
