{ lib, pkgs, ... }:

# This creates a new 'nvidia-offload' program that runs the application passed to it on the GPU
#   As per https://nixos.wiki/wiki/Nvidia
#   Upstream:
#   - https://github.com/NixOS/nixpkgs/blob/nixos-22.11/nixos/modules/hardware/video/nvidia.nix
#   - https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/nvidia.nix
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
  environment.systemPackages = [ nvidia-offload ];

  hardware.nvidia = {
    # Use opensourced kernel module:
    #   https://github.com/NixOS/nixpkgs/pull/172660
    open = true;

    # kernel modesetting:
    #   https://wiki.archlinux.org/title/Kernel_mode_setting
    #   https://en.wikipedia.org/wiki/Direct_Rendering_Manager
    modesetting.enable = lib.mkDefault true;

    # PRIME offload - gpu on demand
    #   https://wiki.archlinux.org/title/PRIME
    prime = { offload.enable = lib.mkDefault true; };
  };
}
