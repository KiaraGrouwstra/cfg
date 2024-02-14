{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.toggles.databases;
in {
  options.toggles.databases.enable = mkEnableOption "databases";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      ensureDatabases = [];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
