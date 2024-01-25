{ lib, inputs, buildGoModule, ... }:

buildGoModule rec {
  pname = "hcloud-csi-driver";
  version = "2.6.0";

  src = inputs.hcloud-csi-driver;

  vendorHash = "sha256-Wxyg+ygQiBCCwX1jOR0Kb+iAHdpFf4ZNTTBYMEaaKoc=";

  subPackages = [ "." ];

  # some tests require a running docker service
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/hetznercloud/csi-driver";
    description = "Kubernetes Container Storage Interface driver for Hetzner Cloud Volumes";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
