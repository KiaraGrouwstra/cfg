{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.files;
in {
  options.toggles.files.enable = mkEnableOption "files";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## file browser
      gnome.nautilus
      gnome.nautilus-python
      nautilus-open-any-terminal # manually patch gsettings: https://github.com/NixOS/nixpkgs/issues/259586#issuecomment-1752107159
      ranger
      mc
      baobab

      ## file handling
      xdg-utils
      handlr
      mimeo
      desktop-file-utils

      ## compression
      zip
      unzip
      zlib

      ## backups
      borgbackup
      borgmatic
      vorta

      ## file sharing
      nextcloud-client
      sshfs
      nodePackages.webtorrent-cli
      onionshare-gui
    ];

    services.syncthing.enable = true;

  };
}

