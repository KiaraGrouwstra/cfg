{lib, pkgs, ...}: {
  home.packages = with pkgs; [
    nixpkgs-fmt
    nixd
    nil
  ];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in
    with exts; [
      jnoortheen.nix-ide
      kamadorueda.alejandra
    ];
}
