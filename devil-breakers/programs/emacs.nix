{ emacs-overlay, doom, pkgs, lib, system, ... }: {
  # imports = [ doom.hmModule ];

  programs.emacs = {
    enable = true;
    # package = emacs-overlay.packages.${system}.emacsPgtk;
    # package = pkgs.emacsPgtk;
    package = pkgs.emacs29-pgtk;
  };

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };
}
