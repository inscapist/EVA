{ pkgs, ... }:

{
  home.packages = with pkgs.zathuraPkgs; [
    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/misc/zathura
    zathura_pdf_mupdf
    # zathura_pdf_poppler
  ];

  programs.zathura = {
    enable = true;
  };
}
