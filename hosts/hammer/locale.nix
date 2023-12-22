{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.locale;
in {
  options.toggles.locale.enable = mkEnableOption "locale";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS        = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT    = "nl_NL.UTF-8";
      LC_MONETARY       = "nl_NL.UTF-8";
      LC_NAME           = "nl_NL.UTF-8";
      LC_NUMERIC        = "nl_NL.UTF-8";
      LC_PAPER          = "nl_NL.UTF-8";
      LC_TELEPHONE      = "nl_NL.UTF-8";
      LC_TIME           = "nl_NL.UTF-8";
    };
  };
}
