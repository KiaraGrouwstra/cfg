{
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.rqbit = {
    Unit = {
      Description = "rqbit";
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = ''${lib.getExe pkgs.rqbit} --http-api-listen-addr 127.0.0.1:3029 server start ~/Downloads'';
    };
  };
}
