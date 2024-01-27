{ lib, config, pkgs, inputs, system, ... }:

with lib;

let cfg = config.toggles.packaging;
in {
  options.toggles.packaging.enable = mkEnableOption "packaging";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## nix
      nixFlakes
      dconf2nix
      any-nix-shell
      nix-direnv
      nixos-gui
      nixpkgs-review

      ## packaging
      nix-software-center
      gnome.gnome-software
      appimage-run
      emacsPackages.guix

      ## config
      gnome.dconf-editor
      nixos-conf-editor
      glib # gsettings

    ];
  };
}
