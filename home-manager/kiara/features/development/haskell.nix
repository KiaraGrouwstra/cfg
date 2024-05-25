{
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.haskellPackages.haskell-language-server
  ];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.justusadam.language-haskell
    exts.haskell.haskell
  ];
  # programs.vscode.haskell = {
  #   enable = true;
  #   hie.enable = true;
  # };
}
