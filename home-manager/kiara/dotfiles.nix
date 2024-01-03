{ lib, pkgs, ... }:

let
  homeFolder = (baseDir:
    let
      makePath = (breadcrumbs: baseDir + "/${lib.strings.concatStringsSep "/" breadcrumbs}");
      fileImport = (breadcrumbs: type: { "${lib.strings.concatStringsSep "/" breadcrumbs}".source = makePath breadcrumbs; });
      iterDir = (breadcrumbs: let
          fileSet = builtins.readDir (makePath breadcrumbs);
          processItem = (location: type: let
              breadcrumbs' = breadcrumbs ++ [location];
            in
              if
                type == "regular"
              then
                [ (fileImport breadcrumbs' type) ]
              else if
                type == "directory"
              then
                iterDir breadcrumbs'
              else
                []
          );
        in
          lib.attrsets.mapAttrsToList processItem fileSet
      );
    in
      lib.attrsets.mergeAttrsList (lib.lists.flatten (iterDir []))
  );

  autoStartLinks = lib.mapAttrs' (desktopName: package: lib.nameValuePair
    ".config/autostart/${desktopName}.desktop"
    { source = "${package}/share/applications/${desktopName}.desktop"; }
  );
in

{

  home.file = (homeFolder ./dotfiles)
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
