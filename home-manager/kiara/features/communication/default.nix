{pkgs, ...}: {
  home.persistence."/persist/home/kiara".directories = [
    ".thunderbird"
    ".cache/thunderbird"
    ".local/share/TelegramDesktop"
    ".config/nyxt"
    ".local/share/nyxt"
  ];

  home.packages = with pkgs; [
    ## email
    betterbird
    offlineimap
    hydroxide

    ## chat / communications
    telegram-desktop
    signal-desktop

    ## web browsers
    wget
    curl
    nyxt
  ];
}
