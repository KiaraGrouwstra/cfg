{pkgs, ...}: {
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs;};
  in
    with exts; [
      meraymond.idris-vscode
    ];
}
