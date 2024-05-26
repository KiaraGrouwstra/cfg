{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.vdirsyncer];

  home.persistence = {
    "/persist/home/kiara".directories = [
      "Calendars"
      "Contacts"
      ".local/share/vdirsyncer"
    ];
  };

  xdg.configFile."vdirsyncer/config".text = let
    host = "https://cloud.disroot.org";
    user = "cinereal";
    cmd = ''["command", "cat", "${config.sops.secrets.dav-pw.path}"]'';
  in
    /*
    ini
    */
    ''
      [general]
      status_path = "~/.local/share/vdirsyncer/status"

      [pair contacts]
      a = "contacts_local"
      b = "contacts_remote"
      collections = ["from a", "from b"]
      conflict_resolution = "b wins"

      [storage contacts_local]
      type = "filesystem"
      path = "~/Contacts"
      fileext = ".vcf"

      [storage contacts_remote]
      type = "carddav"
      url = "${host}"
      username = "${user}"
      password.fetch = ${cmd}

      [pair calendars]
      a = "calendars_local"
      b = "calendars_remote"
      collections = ["from a", "from b"]
      metadata = ["color"]
      conflict_resolution = "b wins"

      [storage calendars_local]
      type = "filesystem"
      path = "~/Calendars"
      fileext = ".ics"

      [storage calendars_remote]
      type = "caldav"
      url = "${host}"
      username = "${user}"
      password.fetch = ${cmd}
    '';

  systemd.user.services.vdirsyncer = {
    Unit = {
      Description = "vdirsyncer synchronization";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
    };
  };
  systemd.user.timers.vdirsyncer = {
    Unit = {
      Description = "Automatic vdirsyncer synchronization";
    };
    Timer = {
      OnBootSec = "30";
      OnUnitActiveSec = "5m";
    };
    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
