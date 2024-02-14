{...}: {
  imports = [
    ./hardware-configuration.nix
    ./xserver.nix
    ./databases.nix
    ./firefox.nix
    ./fonts.nix
    ./greetd.nix
    ./guix.nix
    ./hashicorp.nix
    ./niri.nix
    ./locale.nix
    ./power.nix
    ./networking.nix
    ./sound.nix
    ./virtualisation.nix
  ];
}
