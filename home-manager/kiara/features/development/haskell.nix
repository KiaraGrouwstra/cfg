{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    haskellPackages.haskell-language-server
  ];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs lib;};
  in
    with exts; [
      justusadam.language-haskell
      haskell.haskell
    ];
  # programs.vscode.haskell = {
  #   enable = true;
  #   hie.enable = true;
  # };
}
