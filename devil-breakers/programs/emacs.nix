{ doom, pkgs, ... }: {
  imports = [ doom.hmModule ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacs-gtk;
  };
}
