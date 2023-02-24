{ pkgs, inputs, ... }: {

  imports = [ inputs.hyprland.nixosModules.default ];

  # Configuration
  # https://github.com/hyprwm/Hyprland/blob/main/nix/module.nix
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = false;
      hidpi = false;
    };
    nvidiaPatches = false;
  };

  environment.systemPackages = with pkgs; [
    grim # screen image capture
    mako # notification daemon
    slurp # screen area selection tool
    wl-clipboard # clipboard CLI utilities
  ];

  services.xserver = {
    # A misleading option. Has nought to do with startx
    # it simply means do not enable any display
    displayManager.startx.enable = true;
  };

}
