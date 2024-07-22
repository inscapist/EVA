{ pkgs, ... }:

{
  fileSystems."/".options = [ "noatime" ];

  services = {
    # firmware update
    fwupd.enable = true;
    # https://opensource.com/article/20/2/trim-solid-state-storage-linux
    fstrim.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  hardware.graphics = {
    enable = true;
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
