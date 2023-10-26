{ config, pkgs, ... }:

{

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [
    "wifi 50"
    "H369A15D3AE"
  ];

  networking.wireless.enable = true;
  networking.wireless.networks = {
    "wifi 50" = {
      psk = config.sops.secrets.wifi-password-home.path;
    };
    "H369A15D3AE" = {
      psk = config.sops.secrets.wifi-password-woerden.path;
    };
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

}
