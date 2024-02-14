{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.toggles.tools;
in {
  options.toggles.tools.enable = mkEnableOption "tools";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## terminals
      kitty
      wezterm

      ## command-line utilities
      zsh
      tealdeer
      thefuck
      jaq
      jq # https://github.com/wofr06/lesspipe/issues/145
      pandoc # lesspipe

      ## command-line dropins
      xxh
      bat
      ripgrep
      eza

      ## networking
      networkmanager_dmenu

      ## credentials / security
      pass
      keepassxc
      browserpass
      gnupg
    ];

    ## command-line utilities

    programs.command-not-found.enable = true;

    # shell-agnostic style
    programs.starship = {
      enable = false; # too slow
      enableZshIntegration = true;
      # https://starship.rs/config/
      # .config/starship.toml
      # settings = {};
    };

    # argument completer
    programs.carapace = {
      enable = true;
      enableZshIntegration = true;
    };

    ## credentials / security

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "curses";
    };

    programs.browserpass = {
      # enable = true;  # Error installing file '.mozilla/native-messaging-hosts/com.github.browserpass.native.json' outside $HOME
      browsers = ["firefox"];
    };
  };
}
