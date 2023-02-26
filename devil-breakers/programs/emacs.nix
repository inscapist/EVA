{ emacs-overlay, doom, pkgs, lib, system, ... }: {
  # imports = [ doom.hmModule ];

  # # XXX does no work..
  # # https://github.com/nix-community/nix-doom-emacs/issues/318
  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom.d;
  #   emacsPackage = emacs-overlay.packages.${system}.emacsPgtk;
  # };

  programs.emacs = {
    enable = true;
    # package = emacs-overlay.packages.${system}.emacsPgtk;
    package = pkgs.emacs-gtk;
  };

  home.file.".doom.d" = {
    source = ./doom.d;
    # recursive = true;
  };
}
