{ pkgs, ... }: {
  programs = {
    # https://nix-community.github.io/home-manager/options.html#opt-programs.tmux.enable
    # https://github.com/sagittaros/dotfiles/blob/master/.tmux.conf
    tmux = {
      enable = true;

      baseIndex = 1;
      mouse = true;
      prefix = "`";
      terminal = "screen-256color";

      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.yank
      ];

      # https://github.com/iamverysimp1e/dots/blob/main/configs/tmux/.tmux.conf
      extraConfig = ''
        # https://unix.stackexchange.com/questions/568260/how-is-default-terminal-compared-to-tmux-terminal-overrides
        set -ga terminal-overrides ",*256col*:Tc"

        # disable bell
        set -g bell-action none

        # my keymaps
        bind \\ split-window -h -c "#{pane_current_path}" # split horizontally
        bind - split-window -v -c "#{pane_current_path}"  # split vertically
        bind n new-window -c "#{pane_current_path}"
        bind e command-prompt 'rename-window %%'
        unbind s
        bind s command-prompt 'rename-session %%'
        bind , previous-window
        bind . next-window
        unbind x
        bind x kill-pane                                  # kill pane without confirmation
        bind r source-file ~/.tmux.conf                   # reload tmux config
        unbind o
        bind o choose-tree -Zw
        unbind w
        bind w select-pane -t :.+

        # clear tmux history with ctrl+K (uppercase)
        # conditional clear screen, do nothing if in vim
        is_vim="isvim2 #{pane_tty}"
        unbind K
        bind K if-shell "$is_vim" "" "send-keys -R \; send-keys C-l \; clear-history"


        # status bar theme
        # https://gist.github.com/rajanand02/9407361
        set -g status 'off'
        # set -g status-interval 2
        # set -g status-position top
        # set -g status-bg 'colour235'
        # set -g status-justify 'left'
        # set -g status-left ""
        # set -g status-right ""
        # set -g message-style fg='colour222',bg='colour238'
        # set -g message-command-style fg='colour222',bg='colour238'
        # set -g pane-border-style fg='colour238'
        # set -g pane-active-border-style fg='colour11'
        # setw -g window-status-separator ""
        # setw -g window-status-activity-style fg='colour11',bg='colour235',none
        # setw -g window-status-style fg='colour121',bg='colour235',none

        # setw -g window-status-format '#[fg=colour8,bg=colour235] #W '
        # setw -g window-status-current-format '#[fg=colour11,bg=colour235,bold] #W '
      '';
    };
  };
}
