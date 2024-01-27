{ pkgs ? import <nixpkgs> {}, ... }:
let
  version = "0.1.0";

in pkgs.stdenv.mkDerivation {
  name = "Nixos_Gui-${version}";
  system = "x86_64-linux";
  src = pkgs.fetchurl {
        url = "https://github.com/celestialme/Nixos-Gui/archive/47ee6b29713ba04e4a088b31778fd1e0e358f087.tar.gz";
        sha256= "sha256-x4ld1SIg7q8qBYifgY89mXY3vl2S0JX5nsKsaEzUo6Y=";
      };
  nativeBuildInputs = [
    pkgs.autoPatchelfHook
  ];
  buildInputs = [
       pkgs.openssl
       pkgs.webkitgtk
  ];

  unpackPhase = "
  tar -xvf $src
  ";
  installPhase = ''
     mkdir -p $out
     echo "current dir"
     ls -a

    cp -r ./Nixos-*/usr/* $out
  '';
}
