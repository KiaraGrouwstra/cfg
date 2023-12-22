{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.gaming;
in {
  options.toggles.gaming.enable = mkEnableOption "gaming";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    nixpkgs.config.allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];
  };
}
