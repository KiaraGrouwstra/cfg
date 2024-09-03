{
  lib,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".thunderbird"
    ".cache/thunderbird"
    ".local/share/TelegramDesktop"
    ".config/Signal"
    ".tor project"
  ];

  home.packages = lib.attrValues {
    inherit
      (pkgs)
      ## email
      
      thunderbird-bin
      offlineimap
      hydroxide
      ## chat / communications
      
      telegram-desktop
      signal-desktop
      ## web browsers
      
      wget
      curl

      ## torrents
      transmission_4
      ;
  };
}
