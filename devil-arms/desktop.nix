{ pkgs, inputs, ... }: {
  imports = [
    # https://github.com/hyprwm/Hyprland/blob/1c9a0be8c40ee47cd438ab33f2bfe4184b19b8a7/nix/module.nix#L45-L66
    inputs.hyprland.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    grim # screen image capture
    mako # notification daemon
    oguri # animated background utility
    slurp # screen area selection tool
    wl-clipboard # clipboard CLI utilities
  ];

  # Configuration
  # https://wiki.hyprland.org/Configuring/Environment-variables/
  programs = { hyprland.enable = true; };

  nix = {
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  services.xserver = {
    # A misleading option. Has nought to do with startx
    # it simply means do not enable any display
    displayManager.startx.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

}
