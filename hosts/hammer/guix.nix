{ config, lib, ... }:

with lib;

let cfg = config.toggles.guix;
in {
  options.toggles.guix.enable = mkEnableOption "guix";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {

    services.guix = {
      enable = true;
    };
    systemd.services.guix-daemon.serviceConfig.Nice = 19;
  };
}
