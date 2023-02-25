{ pkgs, inputs, ... }: {

  imports = [ inputs.hyprland.nixosModules.default ];

  # Configuration
  # https://github.com/hyprwm/Hyprland/blob/main/nix/module.nix
  # NOTE: it is important that the settings are in sync with home manager's
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = false;
      hidpi = false;
    };
    nvidiaPatches = false;
  };

  services.xserver = {
    # A misleading option. Has nought to do with startx
    # it simply means do not enable any display
    displayManager.startx.enable = true;
  };

}
