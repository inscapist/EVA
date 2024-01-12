{ pkgs, inputs, ... }: {

  imports = [ inputs.hyprland.nixosModules.default ];

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Configuration
  # https://github.com/hyprwm/Hyprland/blob/main/nix/module.nix
  # NOTE: it is important that the settings are in sync with home manager's
  programs.hyprland = {
    enable = true;
    xwayland = { enable = true; };
  };

  # Hyprland module does a lot of configuration for us, but it is
  # good to make them explicit so nix can check conflicts for us.
  #   https://github.com/hyprwm/Hyprland/blob/e3027248470dab4553273368de85d0f4cf357f78/nix/module.nix#L77-L104
  environment = { sessionVariables = { NIXOS_OZONE_WL = "1"; }; };
  fonts.enableDefaultPackages = true;
  hardware.opengl.enable = true;
  programs = {
    dconf.enable = true;
    xwayland.enable = true;
  };
  security.polkit.enable = true;
  xdg.portal = { enable = true; };

  # A misleading option. Has nought to do with startx
  # it simply means do not enable any display
  services.xserver = { displayManager.startx.enable = true; };

}
