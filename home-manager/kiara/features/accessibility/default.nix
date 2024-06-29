{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./local-ai.nix
  ];

  home.packages = lib.attrValues {
    inherit
      (pkgs)
      ## mobile
      
      wvkbd
      ## speech / TTS
      
      speechd
      orca
      ffmpeg
      openai-whisper-cpp
      # AI
      
      mods
      gpt4all
      ;
  };

  home.persistence."/persist/home/kiara".directories = [
    ".config/kdeconnect"
    ".local/share/nomic.ai/GPT4All"
  ];
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
