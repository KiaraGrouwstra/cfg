{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./yazi.nix
    ./pistol.nix
  ];

  home.persistence."/persist/home/kiara".directories = [
    ".config/Thunar"
    ".config/Nextcloud"
    ".local/share/Nextcloud"
  ];

  home.packages = lib.attrValues {
      inherit
        (pkgs)
        # security
        seahorse
        rage
        sops
        ## compression
        
        unar
        ## file sync
        
        nextcloud-client
        ;
    };

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
