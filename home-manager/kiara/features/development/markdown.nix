{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      marksman
      ;
  };
  programs.neovim.plugins = lib.attrValues {
    inherit
      (pkgs.vimPlugins)
      coc-markdownlint
      ;
  };
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.davidanson.vscode-markdownlint
    exts.marp-team.marp-vscode
  ];
}
