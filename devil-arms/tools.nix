{ pkgs, ... }:
{

  services.postgresql = {
    enable = false;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  environment = {
    variables = {
      EDITOR = "hx";
    };
    systemPackages =
      with pkgs;
      [
        bc
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
        zgrviewer
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
        nix-du
        restic # required for backing up stuff to backblaze(b2 protocol)
      ];
  };
}
