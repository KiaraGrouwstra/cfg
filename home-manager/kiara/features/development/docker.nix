{
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.nodePackages.dockerfile-language-server-nodejs
  ];
  programs.neovim.plugins = [pkgs.vimPlugins.coc-docker];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in [
    exts.ms-azuretools.vscode-docker
  ];
}
