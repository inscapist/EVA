{ pkgs, ... }:

{
  # services.easyeffects.enable = true;

  home.packages = with pkgs; [
    #-- education --#
    # celestia
    # stellarium
    # octave

    #-- productivity --#
    # calibre
    # lsix

    #-- others/vanity/fun? --#
    # cmatrix
    # cbonsai
    # nyancat

    (pkgs.writeShellScriptBin "tclock" ''
      if [ "$#" -eq 0 ]; then
        exec ${pkgs.tty-clock}/bin/tty-clock -c -s
      fi

      exec ${pkgs.tty-clock}/bin/tty-clock "$@"
    '')

    spotify
    jamesdsp
    discord
    wechat
    anytype

    (pkgs.writeShellScriptBin "reset-desktops" ''
      # First, switch to each workspace to ensure it exists
      for i in {1..9}; do
        ${pkgs.i3}/bin/i3-msg "workspace $i" >/dev/null 2>&1
      done

      # Now move workspaces to correct outputs
      for i in {1..5}; do
        ${pkgs.i3}/bin/i3-msg "workspace $i; move workspace to output DP-4"
      done

      for i in {6..9}; do
        ${pkgs.i3}/bin/i3-msg "workspace $i; move workspace to output eDP-1"
      done
    '')
  ];
}
