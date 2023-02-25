{ emacs-overlay, doom, pkgs, lib, system, ... }: {
  imports = [ doom.hmModule ];

  programs.doom-emacs = {
    enable = true;

    package = let
      emacsPgtk = emacs-overlay.packages.${system}.emacsPgtk.override {
        withXwidgets = false;
      };
    in emacsPgtk;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacs-gtk;
  };
}
