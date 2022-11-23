{ config, pkgs, lib, ... }: {

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
    #enableNvidia = true;
    enableOnBoot = false;
    liveRestore = false;
  };

  virtualisation.virtualbox = {
    host.enable = false;

    # Supports:
    #   USB 2.0/3.0 devices, VirtualBox RDP, disk encryption, NVMe and PXE boot for Intel cards
    host.enableExtensionPack = true;

    # VirtualBox Guest additions
    #virtualisation.virtualbox.guest.enable = true;
  };
}
