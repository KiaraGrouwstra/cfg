{
  pkgs,
  lib,
  ...
}: {
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs lib;};
  in
    with exts; [
      lextudio.restructuredtext
      trond-snekvik.simple-rst
      swyddfa.esbonio
    ];
}
