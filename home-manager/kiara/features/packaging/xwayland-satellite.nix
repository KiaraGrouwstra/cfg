{config, ...}: let
  inherit (config.commands) xwayland-satellite;
in {
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside your Wayland";
      BindsTo = "graphical-session.target";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = xwayland-satellite;
      NotifyAccess = "all";
      StandardOutput = "journal";
    };
  };
}
