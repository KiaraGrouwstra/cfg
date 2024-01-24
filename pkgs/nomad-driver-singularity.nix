{ lib, inputs, buildGoModule }:

buildGoModule rec {
  pname = "nomad-driver-singularity";
  version = "1.0.0-alpha2"; # v

  src = inputs.nomad-driver-singularity;

  vendorHash = "sha256-24yGKhd2GBHv2QDXd5hv90MBWM8MWHALyxHJVoayOZE=";

  subPackages = [ "." ];

  # doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/hpcng/nomad-driver-singularity";
    description = "HashiCorp Nomad driver plugin - Singularity";
    platforms = platforms.linux;
    license = licenses.mpl20;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
