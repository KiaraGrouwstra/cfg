{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-python
    coc-pyright
  ];
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit pkgs;};
  in
    with exts; [
      ms-python.python
    ];
}
