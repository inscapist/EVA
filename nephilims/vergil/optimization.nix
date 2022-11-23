{ pkgs, ... }:

{
  boot = {
    kernel.sysctl = {
      # Refuse ICMP echo requests
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "fs.inotify.max_user_watches" = "1048576";
    };

    # https://discourse.nixos.org/t/new-install-hangs-on-boot/21435/10
    extraModprobeConfig = ''
      options i915 force_probe=46a6
    '';
  };

  services = {
    fwupd.enable = true; # firmware update
    fprintd.enable = true; # fingerprint scanner
    xserver.videoDrivers = [ "modesetting" "nvidia" ];

    # Monitor Intel CPU's temporature
    #   /necessity or legacy? swelling battery?/
    #   https://github.com/intel/thermal_daemon
    #   https://www.phoronix.com/review/intel-thermald-tgl
    # thermald.enable = true;
  };

  fileSystems."/".options = [ "noatime" ];

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    video.hidpi.enable = true;
  };

  hardware.nvidia.prime = {
    # used in conjunction with Prime Offload
    # https://github.com/NixOS/nixpkgs/blob/2ea79e0fe445f3fe4f7ac355e12b60ca0e2bd1fa/nixos/modules/hardware/video/nvidia.nix#L71-L89
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  hardware.opengl = {
    enable = true;
    # Hardware video acceleration:
    #   https://nixos.wiki/wiki/Accelerated_Video_Playback
    #   https://wiki.archlinux.org/title/Hardware_video_acceleration
    #   https://wiki.archlinux.org/title/OpenGL
    #   https://discourse.nixos.org/t/hardware-acceleration-on-firefox/7947/18
    #
    #   For normal use, VA-API is sufficient with the choice of either i965 or iHD (newer).
    #   Ignore VDPAU and NvDecode/NvEncode
    #
    #   Verify hardware acceleration with vainfo (equivalent of glxinfo):
    #   $ nix-shell -p libva-utils --run vainfo
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    ];
  };

  powerManagement.powertop.enable = true;
}
