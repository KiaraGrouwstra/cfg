{
  pkgs,
  inputs,
  ...
}:
with inputs; let
  inherit (pkgs) system;
in {
  anyrun = "${anyrun.packages.${system}.anyrun}/bin/anyrun";
  symbols = "${anyrun.packages.${system}.symbols}/bin/symbols";
}
