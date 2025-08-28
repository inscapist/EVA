{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    cudaPackages.cudatoolkit
    linuxPackages.nvidia_x11
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:${pkgs.linuxPackages.nvidia_x11}/lib:$LD_LIBRARY_PATH
    export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}
    source $HOME/.local/share/../bin/env
  '';
}