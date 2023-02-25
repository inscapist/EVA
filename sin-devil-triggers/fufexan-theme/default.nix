{ pkgs, lib, config, ... }: {
  imports = [ ./wlogout.nix ./wofi-style.nix ];

  home.file.".config" = {
    source = ./config;
    recursive = true;
  };
}
