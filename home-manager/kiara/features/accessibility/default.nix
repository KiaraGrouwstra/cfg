{
  pkgs,
  lib,
  ...
}: {
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
      
      local-ai
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
