{
  lib,
  pkgs,
  ...
}: {
  programs.neovim.plugins = lib.attrValues {
    inherit
      (pkgs.vimPlugins)
      coc-python
      coc-pyright
      ;
  };
  programs.vscode.extensions = let
    exts = (import ../../vscode-extensions) {inherit lib pkgs;};
  in
    [
      exts.charliermarsh.ruff
    ]
    ++ lib.attrValues {
      inherit
        (exts.ms-python)
        python
        black-formatter
        mypy-type-checker
        ;
    };
}
