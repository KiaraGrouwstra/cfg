{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ## email
    betterbird
    offlineimap
    hydroxide

    ## chat / communications
    telegram-desktop
    flare

    ## web browsers
    tor-browser
    wget
    curl
    lynx # lesspipe
  ];
}
