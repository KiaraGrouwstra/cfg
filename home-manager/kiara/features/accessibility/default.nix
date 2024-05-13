{pkgs, ...}: {
  home.packages = with pkgs; [
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
  ];

  home.persistence."/persist/home/kiara".directories = [
    ".config/kdeconnect"
  ];
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
