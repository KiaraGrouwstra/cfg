{ lib, ... }:

let

  # (v: 2 * v) -> { a = 1; } -> { a = 2; }
  mapVals = f: lib.mapAttrs (_: f);

  # get an object of files in a directory with a given suffix
  # ".ext" -> "a/b" -> { "foo" = "a/b/foo.ext"; "bar" = "a/b/bar.ext"; }
  dirAttrs = let

    # ".ext" -> "a/b.ext" -> "b"
    fileAttrName = suffix: path: let
      ext = lib.last (lib.splitString "." path);
    in lib.removeSuffix suffix (builtins.baseNameOf path);

    # maps a file to a path
    # ".ext" -> "a/b" -> "c/d.ext" -> { name = "d"; value = "a/b/c/d.ext"; }
    fileAttrInPath = suffix: path: name: {
      name = fileAttrName suffix name;
      value = path + "/${name}";
    };

  in suffix: path: lib.mapAttrs'
    (name: _: fileAttrInPath suffix path name)
    (lib.filterAttrs
      (name: type: lib.hasSuffix suffix name && type == "regular")
      (builtins.readDir path));

in

{

  inherit
    mapVals
    dirAttrs
    ;

  # { b = 0; } -> { c = { a = 1; } } -> { c = { b = 0; a = 1; } }
  default = defaults: mapVals (v: defaults // v);


  # ".ext" -> ./subdir -> { "foo" = "<CONTENTS OF a/b/foo.ext>"; "bar" = "<CONTENTS OF a/b/bar.ext>"; }
  dirContents = suffix: path: lib.mapAttrs (_: lib.readFile) (dirAttrs suffix path);

  # non-flakes: import from remaining `pkgs/*.nix` files
  importRest = pkgs: lib: inputs: path: (lib.mapAttrs
    (_: file: pkgs.callPackage file { inherit inputs lib; })  # import with the same args, add `...` arg if needed
      (lib.filterAttrs
      (name: _: name != "default")
      (lib.dirAttrs ".nix" path)
    )
  );

  # pkgs -> inputs -> ["a" {b="c";}] -> { "a" = inputs.a.packages.${pkgs.system}.default; "c" = inputs.b.packages.${pkgs.system}.c; }
  dryFlakes = pkgs: inputs: deps: lib.listToAttrs (lib.lists.map (dep:
    if lib.strings.typeOf dep == "string" then {
      name = dep;
      value = let
          packages = inputs."${dep}".packages.${pkgs.system};
        in
          if
            lib.hasAttr dep packages
          then
            packages."${dep}"
          else
            packages.default;
    } else
      let
        k = lib.elemAt (lib.attrNames dep) 0;
        v = dep."${k}";
      in {
        name = v;
        value = inputs."${k}".packages.${pkgs.system}."${v}";
      }
  ) deps);

  # dry mime list
  prioritizeList = let
    prioritize = lower: higher:
      lib.foldl'
        (o: k:
          o // {
            "${k}" =
              let
                v = lib.getAttr k lower;
              in
                if lib.hasAttr k o
                then (lib.getAttr k o) ++ v
                else v;
          }
        )
        higher
        (lib.attrNames lower);
  in
    lib.foldl' prioritize {};

  # recursively symlink any files in a directory from $HOME
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

}
