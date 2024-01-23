{ lib, inputs }:  # , buildGoModule

lib.buildGoModule rec {
  pname = "nomad-driver-singularity";
  version = "1.0.0-alpha2"; # v

  src = inputs.nomad-driver-singularity;

  vendorHash = "";

  subPackages = [ "." ];

  # doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/hpcng/nomad-driver-singularity";
    description = "HashiCorp Nomad driver plugin - Singularity";
    platforms = platforms.linux;
    license = licenses.mpl2;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
