{
  lib,
  config,
  pkgs,
  inputs,
  system,
  ...
}:
with lib; let
  cfg = config.toggles.packaging;
in {
  options.toggles.packaging.enable = mkEnableOption "packaging";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## nix
      any-nix-shell
      nix-direnv
      lazy-desktop

      ## packaging
      appimage-run
    ];

    programs.nix-index = {
      enable = true;
      symlinkToCacheHome = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };

    programs.nix-index-database.comma.enable = true;

  };
}
