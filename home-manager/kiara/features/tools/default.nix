{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.tools;
in {
  options.toggles.tools.enable = mkEnableOption "tools";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## command-line utilities
      kitty
      wezterm
      zsh
      wev
      usbutils
      tealdeer
      thefuck
      dos2unix
      jq
      remarshal
      pandoc

      ## command-line dropins
      xxh
      bat
      ripgrep
      eza

      ## networking
      mtr
      networkmanager_dmenu

      ## virtualization
      podman-compose
      docker-compose
      gnome.gnome-boxes  # broken: https://github.com/NixOS/nixpkgs/issues/226355
      virt-manager

      ## credentials / security
      pass
      keepassxc
      browserpass
      gnupg

    ];

    ## command-line utilities

    programs.command-not-found.enable = true;

    ## credentials / security

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "curses";
    };

    programs.browserpass = {
      enable = true;
      browsers = [
        "firefox"
      ];
    };

  };
}
