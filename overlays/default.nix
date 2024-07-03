# Packages you want to overlay.
# You can change versions, add patches, set compilation flags, anything really.
# https://wiki.nixos.org/wiki/Overlays
{
  lib,
  pkgs,
  ...
}:
lib.importRest {inherit pkgs lib;} ../overlays
# i couldn't just do ./ ...

