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
in

{

  # must `git add .` or new files won't be found
  home.file = (homeFolder ./dotfiles) // {
    ".config/swaync/configSchema.json".source = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
  };
  # ".config/sops/age/keys.txt".source = config.sops.secrets.age-keys.path; # $SOPS_AGE_KEY_FILE # error: attribute 'sops' missing

}
