{ pkgs, inputs, ... }:

{
  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  environment.systemPackages = with inputs.browser-previews.packages.${pkgs.system}; [
    # google-chrome # Stable Release
    google-chrome-beta # Beta Release
    # google-chrome-dev # Dev Release
  ];

  services = {
    ollama = {
      enable = true;
      acceleration = "cuda";
      package = pkgs.ollama.override { acceleration = "cuda"; };

      # Optional: preload models, see https://ollama.com/library
      loadModels = [ "deepseek-r1:8b" ];
    };
    open-webui = {
      enable = true;
      port = 11111;
      environment = {
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        # Disable authentication
        WEBUI_AUTH = "False";
      };
    };
  };
}
