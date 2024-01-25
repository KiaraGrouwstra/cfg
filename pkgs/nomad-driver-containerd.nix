{ lib, inputs, buildGoModule, ... }:

buildGoModule rec {
  pname = "nomad-driver-containerd";
  version = "0.9.4";

  src = inputs.nomad-driver-containerd;

  vendorHash = "sha256-eUvV7F8zphEbL0K5sbLE6B8zka3d5MKojSmR9g+laEg=";

  subPackages = [ "." ];

  meta = with lib; {
    homepage = "https://github.com/roblox/nomad-driver-containerd";
    description = "Nomad task driver for launching containers using containerd.";
    platforms = platforms.linux;
    license = licenses.mpl20;
    maintainers = with maintainers; [ KiaraGrouwstra ];
  };
}
