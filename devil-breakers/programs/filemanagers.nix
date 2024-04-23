{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ranger
    xfce.thunar
  ];
  programs = {
    # https://nix-community.github.io/home-manager/options.html#opt-programs.nnn.package
    nnn = {
      enable = false;
      package = pkgs.nnn.override { withNerdIcons = true; };
      bookmarks = { };
    };
  };
}
