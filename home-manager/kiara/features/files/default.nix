{
  pkgs,
  lib,
  ...
}:
with (import ../../commands/pkgs.nix {inherit pkgs;});
{
  imports = [
    ./yazi.nix
    ./pistol.nix
  ];

  home.packages = with pkgs; [
    ## file handling / metadata
    xdg-utils

    ## compression
    zip
    unzip
    zlib
    unrar-free

    ## file sharing
    nextcloud-client

    # security
    gnome.seahorse

    # previews
    viu
    timg
  ];

  services.syncthing.enable = true;

}
