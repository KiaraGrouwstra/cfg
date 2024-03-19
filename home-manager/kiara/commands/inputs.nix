{pkgs, inputs, ...}:
with inputs; let
  inherit (pkgs) system;
in {
  symbols = "${anyrun.packages.${system}.symbols}/bin/symbols";
}
