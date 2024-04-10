{lib, pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
  ];
  programs.neovim.plugins = [pkgs.vimPlugins.coc-docker];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in
    with exts; [
      ms-azuretools.vscode-docker
    ];
}
