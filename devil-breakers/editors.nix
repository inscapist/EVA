{ nix-doom-emacs, pkgs, ... }:

{
  imports = [ nix-doom-emacs.hmModule ];

  # Whether to enable fontconfig configuration. This will,
  # for example, allow fontconfig to discover fonts and
  # configurations installed through home.packages and nix-env.
  fonts.fontconfig.enable = true;

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
