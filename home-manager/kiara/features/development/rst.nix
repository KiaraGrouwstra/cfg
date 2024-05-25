{
  lib,
  pkgs,
  ...
}: {
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.lextudio.restructuredtext
    exts.trond-snekvik.simple-rst
    exts.swyddfa.esbonio
  ];
}
