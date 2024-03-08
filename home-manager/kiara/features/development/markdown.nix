{
  pkgs,
  lib,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-markdownlint
  ];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs lib;};
  in
    with exts; [
      davidanson.vscode-markdownlint
      marp-team.marp-vscode
    ];
}
