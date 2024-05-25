{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {inherit (pkgs) taplo;};
  programs.neovim.plugins = lib.attrValues {
    inherit
      (pkgs.vimPlugins)
      coc-toml
      ;
  };
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.tamasfe.even-better-toml
  ];
}
