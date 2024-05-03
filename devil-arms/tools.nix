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
        gnupg
        age
        sops
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
        imagemagick
        dmidecode
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
        pgcli
        nix-tree
        restic # required for backing up stuff to backblaze(b2 protocol)
      ];
  };
}
