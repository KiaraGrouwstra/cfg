{pkgs, ...}: {
  home.packages = with pkgs; [
    nixpkgs-fmt
    nixd
    nil
  ];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs;};
  in
    with exts; [
      jnoortheen.nix-ide
    ];
}
