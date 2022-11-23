{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ xclip ];

  services.xserver = {
    enable = true;
    layout = "us";
    # dpi = 125;

    # Speeds up keystrokes. Equivalent of:
    #   xset r rate 250 60
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;

    # modify keymapping, separated by ,
    xkbOptions = "caps:escape";

    libinput = {
      enable = true;
      mouse = {
        naturalScrolling = true;
        middleEmulation = false;
        disableWhileTyping = true;
      };
      touchpad = {
        sendEventsMode = "disabled-on-external-mouse";
        scrollMethod = "twofinger";
        naturalScrolling = true;
        tapping = true;
        tappingDragLock = false;
        disableWhileTyping = true;
      };
    };

  };
}
