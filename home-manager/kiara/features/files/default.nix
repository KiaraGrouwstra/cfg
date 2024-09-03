{
  lib,
  pkgs,
  unstable,
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

  home.packages = [
    # security
    unstable.seahorse
  ] ++ lib.attrValues {
      inherit
        (pkgs)
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
