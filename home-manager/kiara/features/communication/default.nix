{
  lib,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".thunderbird"
    ".cache/thunderbird"
    ".local/share/TelegramDesktop"
    ".config/nyxt"
    ".config/Signal"
    ".local/share/nyxt"
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
      nyxt

      ## torrents
      transmission_4
      ;
  };
}
