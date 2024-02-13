{ lib, pkgs, ... }:

{

  # write `./scripts/*.sh` to `home-manager-path/bin/`
  home.packages = lib.lists.map
    (script: pkgs.writeShellScriptBin script (lib.readFile "${./scripts}/${script}"))
    (lib.filter (file: lib.hasSuffix ".sh" file) (lib.attrNames (builtins.readDir ./scripts)));

}
