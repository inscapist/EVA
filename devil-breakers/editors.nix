{ nix-doom-emacs, pkgs, ... }:

{
  imports = [ nix-doom-emacs.hmModule ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
      withNodeJs = true;
    };

    # doom-emacs = {
    #   enable = true;
    #   doomPrivateDir = ./doom.d;
    #   emacsPackage = pkgs.emacs-gtk;
    # };
  };

  home.packages = with pkgs; [
    #-- LSP --#
    nil
    sumneko-lua-language-server
    gopls
    pyright
    rust-analyzer
    tree-sitter
    #-- Formatters --#
    black
    nixfmt
    rustfmt
    beautysh
    nodePackages.prettier
    #-- Debug --#
    lldb
  ];

  home.file.".config/nvim".source = ./nvim;
}
