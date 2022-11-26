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

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };
}
