{lib, ...}:
with lib; let
  # (v: 2 * v) -> { a = 1; } -> { a = 2; }
  mapVals = f: mapAttrs (_: f);

  # get an object of files in a directory with a given suffix
  # ".ext" -> "a/b" -> { "foo" = "a/b/foo.ext"; "bar" = "a/b/bar.ext"; }
  dirAttrs = let
    # ".ext" -> "a/b.ext" -> "b"
    fileAttrName = suffix: path: let
      ext = last (splitString "." path);
    in
      removeSuffix suffix (builtins.baseNameOf path);

    # maps a file to a path
    # ".ext" -> "a/b" -> "c/d.ext" -> { name = "d"; value = "a/b/c/d.ext"; }
    fileAttrInPath = suffix: path: name: {
      name = fileAttrName suffix name;
      value = path + "/${name}";
    };
  in
    suffix: path:
      mapAttrs' (name: _: fileAttrInPath suffix path name)
      (filterAttrs (name: type: hasSuffix suffix name && type == "regular")
        (builtins.readDir path));
in {
  inherit mapVals dirAttrs;

  # (a -> b -> c) -> b -> a -> c
  flip = f: x: y: f y x;

  # (k: k + k) -> { a = 1; } -> { aa = 1; }
  mapKeys = f: mapAttrs' (k: v: nameValuePair (f k) v);

  # { b = 0; } -> { c = { a = 1; } } -> { c = { b = 0; a = 1; } }
  default = defaults: mapVals (v: defaults // v);

  # ".ext" -> ./subdir -> { "foo" = "<CONTENTS OF a/b/foo.ext>"; "bar" = "<CONTENTS OF a/b/bar.ext>"; }
  dirContents = suffix: path: mapAttrs (_: readFile) (dirAttrs suffix path);

  # non-flakes: import from remaining `pkgs/*.nix` files
  importRest = {pkgs, ...} @ args: path: (mapAttrs (_: file:
      pkgs.callPackage file
      args) # import with the same args, add `...` arg if needed
    
    (filterAttrs (name: _: name != "default") (dirAttrs ".nix" path)));

  # pkgs -> inputs -> ["a" {b="c";}] -> { "a" = inputs.a.packages.${pkgs.system}.default; "c" = inputs.b.packages.${pkgs.system}.c; }
  dryFlakes = pkgs: inputs: deps:
    listToAttrs (flatten (lists.map (dep:
      if strings.typeOf dep == "string"
      then {
        name = dep;
        value = let
          packages = inputs."${dep}".packages.${pkgs.system};
        in
          if hasAttr dep packages
          then packages."${dep}"
          else packages.default;
      }
      else
        mapAttrs (k: v: {
          name = v;
          value = inputs."${k}".packages.${pkgs.system}."${v}";
        }))
    deps));

  # dry mime list
  prioritizeList = let
    prioritize = lower: higher:
      foldl' (o: k:
        o
        // {
          "${k}" = let
            v = getAttr k lower;
          in
            if hasAttr k o
            then (getAttr k o) ++ v
            else v;
        })
      higher (attrNames lower);
  in
    foldl' prioritize {};

  # recursively symlink any files in a directory from $HOME
  homeFolder = baseDir: let
    makePath = breadcrumbs: baseDir + "/${strings.concatStringsSep "/" breadcrumbs}";
    fileImport = breadcrumbs: type: {
      "${strings.concatStringsSep "/" breadcrumbs}".source =
        makePath breadcrumbs;
    };
    iterDir = breadcrumbs: let
      fileSet = builtins.readDir (makePath breadcrumbs);
      processItem = location: type: let
        breadcrumbs' = breadcrumbs ++ [location];
      in
        if type == "regular"
        then [(fileImport breadcrumbs' type)]
        else if type == "directory"
        then iterDir breadcrumbs'
        else [];
    in
      attrsets.mapAttrsToList processItem fileSet;
  in
    attrsets.mergeAttrsList (lists.flatten (iterDir []));
}
