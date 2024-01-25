{ lib, inputs, buildGoModule, ... }:

buildGoModule rec {
  pname = "nomad-driver-nix2";
  version = "0.0.1";

  src = inputs.nomad-driver-nix2;

  vendorHash = "sha256-EQdTxVOBRYQjg7kAB+pFJYcNwk0zlsjjJxM+EO/cK84=";

  subPackages = [ "." ];

  meta = with lib; {
    homepage = "https://git.deuxfleurs.fr/Deuxfleurs/nomad-driver-nix2";
    description = "A driver to run Nix jobs on Nomad";
    platforms = platforms.linux;
    license = licenses.mpl20;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
