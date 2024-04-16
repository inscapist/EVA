{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs-gtk;
    package = pkgs.emacs;
  };

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };
}
