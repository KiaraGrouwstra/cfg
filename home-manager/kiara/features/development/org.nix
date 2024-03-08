{
  pkgs,
  lib,
  ...
}: {
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs lib;};
  in
    with exts; [
      vscode-org-mode.org-mode
    ];
}
