# https://github.com/NixOS/nixpkgs/blob/nixos-22.05/nixos/modules/config/fonts/fonts.nix
# https://github.com/pinpox/nixos/blob/main/modules/fonts/default.nix
{ pkgs, ... }: {
  fonts = {
    fonts = with pkgs; [
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/default.nix
      (nerdfonts.override { fonts = [ "Agave" "Monoid" ]; })

      # icon fonts
      material-symbols

      # normal fonts
      agave
      monoid
      jost
      lexend
      recursive
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      roboto

      # CJK support
      wqy_microhei
      wqy_zenhei
      noto-fonts-cjk
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif
    ];
    fontconfig = {
      defaultFonts = {
        # serif = [ "Recursive Sans Casual Static Medium" ];
        # sansSerif = [ "Recursive Sans Linear Static Medium" ];
        # monospace = [ "Recursive Mono Linear Static" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
