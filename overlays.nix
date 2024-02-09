# This file defines overlays
{ inputs, lib, ... }:

{
  default = _final: prev:
    (import ./packages.nix {
      pkgs = prev;
      inherit inputs lib;
    });
}
