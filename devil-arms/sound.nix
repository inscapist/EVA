{ lib, ... }: {
  # environment.systemPackages = with pkgs; [ pulseaudio ];

  hardware.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;

    # see https://github.com/fufexan/nix-gaming/#pipewire-low-latency
    # lowLatency.enable = true;
  };

  sound.enable = true;
}
