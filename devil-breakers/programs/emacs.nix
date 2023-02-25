{ emacs-overlay, doom, pkgs, lib, system, ... }: {
  # imports = [ doom.hmModule ];

  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom.d;
  #   emacsPackage = emacs-overlay.packages.${system}.emacsPgtk;
  # };

  programs.emacs = {
    enable = true;
    package = emacs-overlay.packages.${system}.emacsPgtk;
  };
}
