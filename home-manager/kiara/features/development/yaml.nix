{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    nodePackages.yaml-language-server
  ];
  programs.neovim.plugins = [pkgs.vimPlugins.coc-yaml];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs lib;};
  in with exts; [
    redhat.vscode-yaml
  ];
}
