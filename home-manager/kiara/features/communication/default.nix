{pkgs, ...}: {
  home.persistence."/persist/home/kiara".directories = [
    ".thunderbird"
    ".local/share/flare"
    ".local/share/TelegramDesktop"
  ];

  home.packages = with pkgs; [
    ## email
    betterbird
    offlineimap
    hydroxide

    ## chat / communications
    telegram-desktop
    flare

    ## web browsers
    wget
    curl
  ];
}
