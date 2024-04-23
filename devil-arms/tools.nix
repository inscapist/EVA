{ pkgs, ... }:
{
  environment = {
    variables = {
      EDITOR = "hx";
    };
    systemPackages =
      with pkgs;
      [
        which
        bat
        curl
        wget
        fd
        tree
        ripgrep
        jq
        fx
        git
        rage
      ]
      ++ [ neovim ]
      ++ [
        httpie
        tokei
        tealdeer
        helix
        unrar
        zip
        unzip
        ouch # compress/decompress stuffs
      ]
      ++ [
        nitch
        dua
        duf
        ncdu
        htop
        bottom
        btop
        glances
        iotop
        hyperfine
      ]
      ++ [
        gcc
        gnumake
        graphviz
        gdb
        hexyl
        poppler_utils
      ]
      ++ [
        tcpdump
        inetutils
        dig
        socat
        netcat
        dive
      ]
      ++ [
        imagemagick
        imv
        gthumb
        feh
        xsel
        asciinema
        pgcli
        dmidecode
      ]
      ++ [ restic ]; # required for backing up stuff to backblaze(b2 protocol)
  };
}
