{
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.nodePackages.yaml-language-server
  ];
  programs.neovim.plugins = [pkgs.vimPlugins.coc-yaml];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.redhat.vscode-yaml
  ];
}
