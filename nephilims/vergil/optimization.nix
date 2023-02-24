{ pkgs, ... }:

{
  boot = {
    kernel.sysctl = { "fs.inotify.max_user_watches" = "1048576"; };

    # https://discourse.nixos.org/t/new-install-hangs-on-boot/21435/10
    extraModprobeConfig = ''
      options i915 force_probe=46a6
    '';
  };

  fileSystems."/".options = [ "noatime" ];

  services = {
    fwupd.enable = true; # firmware update
    fprintd.enable = true; # fingerprint scanner
  };

  hardware.nvidiaOptimus.disable = true;
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true; # vulcan
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
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    ];
  };

  # for debugging
  environment.systemPackages = with pkgs; [
    neofetch
    libva-utils
    pciutils
    lshw
    lsof
  ];
}
