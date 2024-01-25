{ lib, inputs, buildGoModule, ... }:

buildGoModule rec {
  pname = "nomad-driver-singularity";
  version = "1.0.0-alpha2";

  src = inputs.nomad-driver-singularity;

  vendorHash = "sha256-24yGKhd2GBHv2QDXd5hv90MBWM8MWHALyxHJVoayOZE=";

  subPackages = [ "./cmd/driver" ];

  postBuild = ''
    mv $GOPATH/bin/driver $GOPATH/bin/nomad-driver-singularity
  '';

  meta = with lib; {
    homepage = "https://github.com/hpcng/nomad-driver-singularity";
    description = "HashiCorp Nomad driver plugin - Singularity";
    platforms = platforms.linux;
    license = licenses.mpl20;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
