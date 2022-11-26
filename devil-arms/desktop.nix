{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ ];

  services.xserver = { enable = true; };
}
