{pkgs, ...}: {
  home.packages = with pkgs; [
    ## mobile
    wvkbd

    ## speech / TTS
    speechd
    orca

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
