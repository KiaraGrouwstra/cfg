# WARN: this file will get overwritten by $ cachix use <name>
{lib, ...}: let
  folder = ./cachix;
  toImport = name: _value: folder + ("/" + name);
  filterCaches = key: value: value == "regular" && lib.hasSuffix ".nix" key;
  imports =
    lib.mapAttrsToList toImport
    (lib.filterAttrs filterCaches (builtins.readDir folder));
in {
  inherit imports;
  nix.settings = {
    substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org/"];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
