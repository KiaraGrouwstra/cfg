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
      thunderbird
      neomutt
      offlineimap
      hydroxide

      ## chat / communications
      signal-desktop
      signal-desktop-beta
      telegram-desktop
      element-desktop
      signal-cli
      scli
      matrix-commander
      kirc
      halloy
      python3Packages.yowsup
      ricochet
      weechat
      kdeltachat
      # nur.repos.xyenon.kazv  # https://github.com/XYenon/nur-packages/issues/14
      flare

      ## web browsers
      tor-browser
      qutebrowser
      wget
      curl
      lynx
      mercury-browser

    ];

  };
}
