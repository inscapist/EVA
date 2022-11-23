# https://github.com/NixOS/nixpkgs/blob/nixos-22.05/nixos/modules/config/fonts/fonts.nix
# https://github.com/pinpox/nixos/blob/main/modules/fonts/default.nix
{ pkgs, ... }: {
  fonts = {
    fonts = with pkgs; [
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/default.nix
      (nerdfonts.override { fonts = [ "Monoid" ]; })

      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/data/fonts
      ibm-plex
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      recursive
      twemoji-color-font

      # CJK support
      wqy_microhei
      wqy_zenhei
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "IBM Plex Sans" ];
        serif = [ "IBM Plex Sans" ];
        monospace = [ "Monoid Nerd Font" ];
        emoji = [ "Twemoji" ];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
            <description>Emoji fix</description>

            <alias binding="weak">
                <family>sans-serif</family>
                <prefer>
                    <family>Twemoji</family>
                </prefer>
            </alias>

            <alias binding="weak">
                <family>serif</family>
                <prefer>
                    <family>Twemoji</family>
                </prefer>
            </alias>

            <alias binding="weak">
                <family>monospace</family>
                <prefer>
                    <family>Twemoji</family>
                </prefer>
            </alias>
        </fontconfig>
      '';
    };
  };
}
