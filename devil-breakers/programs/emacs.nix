{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk; # or pkgs.emacs
  };

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };
}
