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
      niv

      ## packaging
      inputs.nix-software-center.packages.${pkgs.system}.nix-software-center
      gnome.gnome-software
      appimage-run
      emacsPackages.guix

      ## config
      gnome.dconf-editor
      inputs.nixos-conf-editor.packages.${pkgs.system}.nixos-conf-editor
      glib # gsettings

    ];
  };
}
