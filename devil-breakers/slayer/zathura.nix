{ theme, ... }: {
  programs.zathura = let inherit (theme) colors;
  in {
    enable = true;
    options = {
      recolor = true;
      recolor-darkcolor = "#${colors.crust}";
      recolor-lightcolor = "rgba(0,0,0,0)";
      default-bg = "rgba(0,0,0,0.7)";
      default-fg = "#${colors.text}";

      font = "Roboto 12";

      completion-bg = colors.bg;
      completion-fg = colors.fg;
      completion-highlight-bg = colors.base;
      completion-highlight-fg = colors.fg;
      completion-group-bg = colors.base;
      completion-group-fg = colors.blue;

      statusbar-fg = colors.lavender;
      statusbar-bg = colors.base;
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      notification-bg = colors.base;
      notification-fg = colors.fg;
      notification-error-bg = colors.base;
      notification-error-fg = colors.red;
      notification-warning-bg = colors.base;
      notification-warning-fg = colors.peach;
      selection-notification = true;

      inputbar-fg = colors.text;
      inputbar-bg = colors.base;

      index-fg = colors.fg;
      index-bg = colors.surface0;
      index-active-fg = colors.fg;
      index-active-bg = colors.base;

      render-loading-bg = colors.surface0;
      render-loading-fg = colors.fg;

      highlight-color = colors.subtext1;
      highlight-active-color = colors.pink;
      highlight-fg = colors.pink;

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      zoom-min = "10";
    };
  };
}
