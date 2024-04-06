{...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./xserver.nix
    ./databases.nix
    ./fonts.nix
    ./greetd.nix
    ./guix.nix
    ./niri.nix
    ./locale.nix
    ./power.nix
    ./networking.nix
    ./sound.nix
    ./virtualisation.nix
  ];
}
