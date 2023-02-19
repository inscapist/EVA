{ pkgs, ... }:

{
  fileSystems."/".options = [ "noatime" ];

  services = {
    fwupd.enable = true; # firmware update
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true; # vulcan
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    ];
  };

  # for debugging
  environment.systemPackages = with pkgs; [
    acpi
    neofetch
    nvtop
    libva-utils
    pciutils
    lshw
    lsof
    powertop
    s-tui
    tlp
  ];

  # powerManagement.powertop.enable = true;
}
