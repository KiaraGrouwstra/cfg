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
      jaq
      remarshal
      pandoc

      ## command-line dropins
      xxh
      bat
      ripgrep
      eza

      ## networking
      gnirehtet
      mtr
      networkmanager_dmenu

      ## virtualization
      podman
      podman-compose
      podman-tui
      docker-compose
      lazydocker # TUI
      gnome.gnome-boxes # broken: https://github.com/NixOS/nixpkgs/issues/226355
      virt-manager
      qemu
      arion

      ## credentials / security
      pass
      keepassxc
      browserpass
      gnupg

    ];

    ## command-line utilities

    programs.command-not-found.enable = true;

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
      browsers = [ "firefox" ];
    };

  };
}
