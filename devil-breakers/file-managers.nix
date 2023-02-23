{ pkgs, ... }: {
  home.packages = with pkgs; [ cinnamon.nemo ];
  programs = {
    # https://nix-community.github.io/home-manager/options.html#opt-programs.nnn.package
    nnn = {
      enable = true;
      package = pkgs.nnn.override { withNerdIcons = true; };
      bookmarks = { };
    };
  };
}
