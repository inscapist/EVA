{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services = {
    ollama = {
      enable = false;
      acceleration = "cuda";
      package = pkgs.ollama.override { acceleration = "cuda"; };

      # Optional: preload models, see https://ollama.com/library
      # loadModels = [ "deepseek-r1:8b" ];
    };
    open-webui = {
      enable = false;
      port = 2222;
      environment = {
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        # Disable authentication
        WEBUI_AUTH = "False";
      };
    };
  };
}
