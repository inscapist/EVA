{ pkgs, ... }: {
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
}
