{
  lib,
  pkgs,
  ...
}: {
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.vscode-org-mode.org-mode
  ];
}
