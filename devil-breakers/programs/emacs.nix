{ emacs-overlay, doom, pkgs, lib, system, ... }: {
  # imports = [ doom.hmModule ];

  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom.d;
  #   emacsPackage = pkgs.emacs-pgtk;
  # };

  programs.emacs = {
    enable = true;
    # package = emacs-overlay.packages.${system}.emacsPgtk;
    # package = pkgs.emacsPgtk;
    package = pkgs.emacs-pgtk;
  };

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };
}
