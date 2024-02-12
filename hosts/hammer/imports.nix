{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./xserver.nix
    # ./adblock.nix  # messes with wifi pages
    ./databases.nix
    ./firefox.nix
    ./fonts.nix
    ./greetd.nix
    ./guix.nix
    ./hashicorp.nix
    ./hyprland.nix
    ./niri.nix
    ./locale.nix
    ./power.nix
    ./networking.nix
    ./sound.nix
    ./virtualisation.nix
  ];
}
