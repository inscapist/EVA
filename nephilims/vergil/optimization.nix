{ config, pkgs, ... }:

let
  chattr = pkgs.writeShellScriptBin "chattr" "";
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  boot = {
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "1048576";
    };

    # https://discourse.nixos.org/t/new-install-hangs-on-boot/21435/10
    extraModprobeConfig = ''
      options i915 force_probe=46a6
    '';
  };

  fileSystems."/".options = [ "noatime" ];

  services = {
    fwupd.enable = true; # firmware update
    fprintd.enable = true; # fingerprint scanner
    fstrim.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  # hardware.nvidiaOptimus.disable = true;
  boot.blacklistedKernelModules = [
    "nouveau"
    # "nvidia"
  ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    prime = {
      # lspci -nn | grep -E 'VGA|3D'
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      # Optimus PRIME Option A: Offload Mode
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics = {
    enable = true;
    # Hardware video acceleration:
    #   https://nixos.wiki/wiki/Accelerated_Video_Playback
    #   https://wiki.archlinux.org/title/Hardware_video_acceleration
    #   https://wiki.archlinux.org/title/OpenGL
    #   https://discourse.nixos.org/t/hardware-acceleration-on-firefox/7947/18
    #
    #   For normal use, VA-API is sufficient with the choice of either i965 or iHD (newer).
    #   Ignore VDPAU and NvDecode/NvEncode on Nvidia
    #
    #   Verify hardware acceleration with vainfo (equivalent of glxinfo):
    #   $ nix-shell -p libva-utils --run vainfo
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # for debugging
  environment.systemPackages = with pkgs; [
    neofetch
    libva-utils
    pciutils
    lshw
    lsof
    nvidia-offload
    chattr
  ];
}
