{ emacs-overlay, doom, pkgs, lib, system, ... }: {
  imports = [ doom.hmModule ];

  nixpkgs.overlays = [ emacs-overlay.overlay ];

  # XXX does no work..
  # https://github.com/nix-community/nix-doom-emacs/issues/318
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacsPgtk;
  };

  # programs.emacs = {
  #   enable = true;
  #   # package = emacs-overlay.packages.${system}.emacsPgtk;
  #   package = pkgs.emacsPgtk;
  # };

  # home.file.".doom.d" = {
  #   source = ./doom.d;
  #   # recursive = true;
  # };
}
