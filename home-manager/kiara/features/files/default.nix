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
    ".local/share/Nextcloud"
  ];

  home.packages = with pkgs; [
    ## compression
    unar

    # security
    rage
    sops
    gnome.seahorse
  ];

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
