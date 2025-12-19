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
        dua
        duf
        btop
        glances
        termscp
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
        poppler-utils
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
