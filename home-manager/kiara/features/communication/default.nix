{ lib, config, pkgs, unfree, ... }:

with lib;

let cfg = config.toggles.communication;
in {
  options.toggles.communication.enable = mkEnableOption "communication";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## email
      thunderbird
      neomutt
      offlineimap
      hydroxide

      ## chat / communications
      signal-desktop
      telegram-desktop
      element-desktop
      signal-cli
      scli
      matrix-commander
      kirc
      halloy
      unfree.zoom-us
      python3Packages.yowsup
      ricochet

      ## web browsers
      chromium
      tor-browser
      qutebrowser
      wget
      curl
      lynx

    ];

    programs.firefox = {
      enable = true;
      policies = {
        DontCheckDefaultBrowser = true;
        DisablePocket = true;
      };
    };

  };
}
