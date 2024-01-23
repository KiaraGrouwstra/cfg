{ lib, inputs }:  # , buildGoModule

lib.buildGoModule rec {
  pname = "nomad-driver-nix2";
  version = "0.0.1";

  src = inputs.nomad-driver-nix2;

  vendorHash = "";

  subPackages = [ "." ];

  # # some tests require a running podman service
  # doCheck = false;

  meta = with lib; {
    homepage = "https://git.deuxfleurs.fr/Deuxfleurs/nomad-driver-nix2";
    description = "A driver to run Nix jobs on Nomad";
    platforms = platforms.linux;
    license = licenses.mpl2;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
