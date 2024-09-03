{
  lib,
  pkgs,
  unstable,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".thunderbird"
    ".cache/thunderbird"
    ".local/share/TelegramDesktop"
    ".config/Signal"
    ".tor project"
  ];

  home.packages = [
      ## chat / communications
      
      unstable.signal-desktop
      unstable.telegram-desktop
  ] ++ lib.attrValues {
    inherit
      (pkgs)
      ## email
      
      thunderbird-bin
      offlineimap
      hydroxide
      ## web browsers
      
      wget
      curl

      ## torrents
      transmission_4
      ;
  };
}
