{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    # package = emacs-overlay.packages.${system}.emacsPgtk;
    # package = pkgs.emacsPgtk;
    package = pkgs.emacs-gtk;
  };

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };
}
