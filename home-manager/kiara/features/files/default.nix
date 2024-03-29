{pkgs, config, ...}:
with config.commands; {
  imports = [
    ./yazi.nix
    ./pistol.nix
  ];

  home.packages = with pkgs; [
    ## compression
    zip
    unzip
    zlib
    unrar-free

    ## file sharing
    nextcloud-client

    # security
    gnome.seahorse
  ];

  services.syncthing.enable = true;
}
