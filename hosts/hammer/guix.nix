{ pkgs, lib, ... }:

{

  # /root/.config/guix/current/lib/systemd/system/guix-daemon.service
  systemd.services.guix-daemon = {
    enable = true;
    description = "Build daemon for GNU Guix";
    serviceConfig = {
      ExecStart = "/var/guix/profiles/per-user/root/current-guix/bin/guix-daemon --build-users-group=guixbuild";
      Environment = [ "GUIX_LOCPATH=/var/guix/profiles/per-user/root/guix-profile/lib/locale" "LC_ALL=en_US.utf8" ];
      RemainAfterExit = "yes";

      # See <https://lists.gnu.org/archive/html/guix-devel/2016-04/msg00608.html>.
      # Some package builds (for example, go@1.8.1) may require even more than
      # 1024 tasks.
      TasksMax = "8192";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # guix
  users.extraUsers = lib.fold (a: b: a // b) { } (builtins.map
    (i: {
      "guixbuilder${i}" = {
        group = "guixbuild";
        extraGroups = [ "guixbuild" ];
        home = "/var/empty";
        shell = pkgs.shadow;
        description = "Guix build user ${i}";
        isSystemUser = true;
      };
    }) [ "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" ]);
  users.extraGroups.guixbuild = { name = "guixbuild"; };

}
