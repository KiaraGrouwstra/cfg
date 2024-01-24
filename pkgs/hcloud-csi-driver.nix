{ lib, inputs, buildGoModule }:

buildGoModule rec {
  pname = "hcloud-csi-driver";
  version = "2.6.0";

  src = inputs.hcloud-csi-driver;

  vendorHash = "";

  subPackages = [ "." ];

  # # some tests require a running podman service
  # doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/hetznercloud/csi-driver";
    description = "Kubernetes Container Storage Interface driver for Hetzner Cloud Volumes";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
