{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ 
      pkgs.proton-ge-bin 
    ];
    protontricks.enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true;

  services = {
    ollama = {
      enable = false;
      package = pkgs.ollama-cuda;

      # Optional: preload models, see https://ollama.com/library
      # loadModels = [ "deepseek-r1:8b" ];
    };
    open-webui = {
      enable = false;
      port = 2222;
      environment = {
        # OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        # Use vLLM's OpenAI-compatible API instead of Ollama
        OPENAI_API_BASE_URL = "http://127.0.0.1:8000/v1";
        OPENAI_API_KEY = "dummy-key";  # vLLM doesn't require a real key
        # Disable authentication
        WEBUI_AUTH = "False";
      };
    };
  };
}
