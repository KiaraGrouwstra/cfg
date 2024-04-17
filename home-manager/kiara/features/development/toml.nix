{
  lib,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-toml
  ];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in
    with exts; [
      tamasfe.even-better-toml
    ];
}
