{ pkgs, ... }:

{

  services.postgresql = {
    enable = true;
    ensureDatabases = [ ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

}
