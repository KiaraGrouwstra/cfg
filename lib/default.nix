{lib, ...}: let
  inherit (lib) getAttr foldl' mapAttrs' last getExe removeSuffix filterAttrs hasSuffix nameValuePair mapAttrs readFile flatten lists strings elemAt splitString attrNames attrValues hasAttr attrsets attrsToList listToAttrs;
  mapVals = f: mapAttrs (_: f);

  # get an object of files in a directory with a given suffix
  # ".ext" -> "a/b" -> { "foo" = "a/b/foo.ext"; "bar" = "a/b/bar.ext"; }
  dirAttrs = let
    # ".ext" -> "a/b.ext" -> "b"
    fileAttrName = suffix: path: removeSuffix suffix (builtins.baseNameOf path);

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

  # (a -> b -> c) -> b -> a -> c
  flip = f: x: y: f y x;

  # (k: k + k) -> { a = 1; } -> { aa = 1; }
  mapKeys = f: mapAttrs' (k: v: nameValuePair (f k) v);

  # { b = 0; } -> { c = { a = 1; } } -> { c = { b = 0; a = 1; } }
  default = lib.attrsets.recursiveUpdate;

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
          if packages ? dep
          then packages."${dep}"
          else packages.default;
      }
      else
        mapAttrs (k: v: {
          name = v;
          value = inputs."${k}".packages.${pkgs.system}."${v}";
        }))
    deps));

  prioritize = lower: higher:
    foldl' (o: k:
      o
      // {
        "${k}" = let
          v = getAttr k lower;
        in
          if o ? k
          then (getAttr k o) ++ v
          else v;
      })
    higher (attrNames lower);

  # dry mime list
  prioritizeList = foldl' prioritize {};

  # recursively symlink any files in a directory from $HOME
  homeFolder = baseDir: let
    makePath = breadcrumbs: baseDir + "/${strings.concatStringsSep "/" breadcrumbs}";
    fileImport = breadcrumbs: _type: {
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

  # pkgs.bat -> { name = "bat"; value = pkgs.bat; }
  attrsFromPackage = pkg: {
    # work around error: the string 'nix' is not allowed to refer to a store path
    name = strings.unsafeDiscardStringContext (last (splitString "/" (getExe pkg)));
    value = pkg;
  };

  # { rofi = pkgs.rofi-wayland; } -> { rofi = "${pkgs.rofi-wayland}/bin/rofi"; }
  dryCommands = mapAttrs (binaryName: package: "${package}/bin/${binaryName}");

  # { "my-key": [url] } -> { substituters = [url]; trusted-public-keys = ["my-key"]; };
  dryCache = attrs: {
    substituters = flatten (attrValues attrs);
    trusted-public-keys = attrNames attrs;
  };

  invert = obj:
    foldl' (acc: pair: let
      inherit (pair) name value;
    in
      acc
      // {
        "${value}" =
          (
            if hasAttr value acc
            then acc."${value}"
            else []
          )
          ++ [name];
      }) {} (attrsToList obj);

  # { "sh" = ["ago" ...]; "py" = [...]; }
  scripts = invert (listToAttrs (lists.map (fname: let frag = elemAt (splitString "." fname); in nameValuePair (frag 0) (frag 1)) (attrNames (builtins.readDir ../scripts))));
in
  assert mapVals (v: 2 * v) {a = 1;} == {a = 2;};
  assert invert {
    a = "x";
    b = "x";
    c = "y";
  }
  == {
    x = ["a" "b"];
    y = ["c"];
  }; {
    inherit
      mapVals
      dirAttrs
      flip
      mapKeys
      default
      dirContents
      importRest
      dryFlakes
      prioritize
      prioritizeList
      homeFolder
      attrsFromPackage
      dryCommands
      dryCache
      invert
      scripts
      ;
  }
