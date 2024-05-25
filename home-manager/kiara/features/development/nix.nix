{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      nixpkgs-fmt
      nixd
      nil
      ;
  };
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.jnoortheen.nix-ide
    exts.kamadorueda.alejandra
  ];
}
