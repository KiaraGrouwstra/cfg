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

  home.packages = with pkgs; [
    ## compression
    unar

    ## file sharing
    nextcloud-client

    # security
    gnome.seahorse
  ];
}
