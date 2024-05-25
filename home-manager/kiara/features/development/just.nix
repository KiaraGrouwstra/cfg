{
  lib,
  pkgs,
  ...
}: {
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.kokakiwi.vscode-just
  ];
}
