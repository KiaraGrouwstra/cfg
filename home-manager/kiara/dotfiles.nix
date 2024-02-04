{ lib, pkgs, ... }:

let
  autoStartLinks = lib.mapAttrs' (desktopName: package: lib.nameValuePair
    ".config/autostart/${desktopName}.desktop"
    { source = "${package}/share/applications/${desktopName}.desktop"; }
  );
in

{

  home.file = (lib.homeFolder ./dotfiles)
  # keys: ls ~/.local/share/applications/
  # vals: ls ~/.nix-profile/bin/
  // autoStartLinks (with pkgs; {
    "org.keepassxc.KeePassXC" = keepassxc;
    "codium" = vscodium;
    "firefox" = firefox;
    "com.nextcloud.desktopclient.nextcloud" = nextcloud-client;
  })
  // {
    # must `git add .` or new files won't be found
    ".config/swaync/configSchema.json".source = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
  };
  # ".config/sops/age/keys.txt".source = config.sops.secrets.age-keys.path; # $SOPS_AGE_KEY_FILE # error: attribute 'sops' missing

}
