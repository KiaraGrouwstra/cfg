{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./adblock.nix  # messes with wifi pages
    # ./databases.nix
    ./greetd.nix
    # ./guix.nix
    ./hyprland.nix
    ./locale.nix
    ./power.nix
    ./networking.nix
    ./sound.nix
    # ./gaming.nix
    # ./virtualisation.nix
  ];
}
