{ pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "sagittaros";
      userEmail = "zen9.felix@gmail.com";

      # signing = {
      #   signByDefault = true;
      #   key = "";
      # };

      aliases = {
        "co" = "checkout";
        "br" = "branch";
        "ci" = "commit";
        "recommit" = "!git add --all; !git commit --amend --no-edit";
        "ver" = "describe --abbrev=0 --tags";
        "st" = "status";
        "reset-remote" =
          "!git reset --hard $(!git rev-parse --abbrev-ref '@{upstream}')";
        "reset-head" = "reset --hard HEAD";
        "reset-back" = "reset --hard HEAD~1";
        "remote-tag" = "ls-remote --tags origin";
        "prune-local" =
          "!git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs !git branch -d";
        "do-not-track" =
          "!git update-index --assume-unchanged $1; !git rm -f $1";
        "local-history" =
          "!git for-each-ref --sort=-committerdate refs/heads/ --color --format='%(color:white)%(committerdate:short)%(color:reset) %(color:bold blue)%(refname:short)%0a%(color:reset)  %(color:bold red)%(authorname):%(color:reset) %(subject)%0a'";
        "remote-history" =
          "!git for-each-ref --sort=-committerdate refs/remotes/ --color --format='%(color:white)%(committerdate:short)%(color:reset) %(color:bold blue)%(refname:short)%0a%(color:reset)  %(color:bold red)%(authorname):%(color:reset) %(subject)%0a'";
      };

      extraConfig = { push.autoSetupRemote = true; };
    };

    lazygit = {
      enable = true;
      settings = {
        # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
        gui.theme = { lightTheme = true; };
      };
    };
  };

}
