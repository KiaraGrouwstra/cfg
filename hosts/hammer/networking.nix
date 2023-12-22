{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.networking;
in {
  options.toggles.networking.enable = mkEnableOption "networking";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    networking.hostName = "hammer"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;
    networking.networkmanager.unmanaged = [
      "wifi 50"
      "H369A15D3AE"
      "publicroam"
      "eduroam"
    ];

    sops.secrets = {
      wifi-password-home = {};
      wifi-password-woerden = {};
      wifi-password-publicroam = {};
      wifi-password-eduroam = {};
      wifi-password-floppy = {};
    };

    networking.wireless.enable = true;
    networking.wireless.networks = {
      "wifi 50" = {
        psk = config.sops.secrets.wifi-password-home.path;
      };
      "H369A15D3AE" = {
        psk = config.sops.secrets.wifi-password-woerden.path;
      };
      "publicroam" = {
        auth = ''
          key_mgmt=WPA-EAP
          eap=PWD
          identity="qyu543@NL"
          password="${config.sops.secrets.wifi-password-publicroam.path}"
        '';
      };
      "eduroam" = {
        auth = ''
          key_mgmt=WPA-EAP
          eap=PWD
          identity="bfdmg@edu.nl"
          password="${config.sops.secrets.wifi-password-eduroam.path}"
        '';
      };
      "Floppy Disk" = {
        psk = config.sops.secrets.wifi-password-floppy.path;
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
  };
}
