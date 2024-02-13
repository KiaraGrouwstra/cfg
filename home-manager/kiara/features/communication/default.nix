{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.communication;
in {
  options.toggles.communication.enable = mkEnableOption "communication";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## email
      betterbird
      offlineimap
      hydroxide

      ## chat / communications
      telegram-desktop
      flare

      ## web browsers
      tor-browser
      wget
      curl
      lynx  # lesspipe

    ];

  };
}
