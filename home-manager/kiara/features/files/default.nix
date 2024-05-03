{
  pkgs,
  config,
  ...
}:
with config.commands; {
  imports = [
    ./yazi.nix
    ./pistol.nix
  ];

  home.persistence."/persist/home/kiara".directories = [
    ".config/Thunar"
    ".config/Nextcloud"
    ".local/share/keyrings"
    ".local/share/Nextcloud"
  ];

  home.packages = with pkgs; [
    ## compression
    unar

    ## file sharing
    nextcloud-client

    # security
    gnome.seahorse
  ];
}
