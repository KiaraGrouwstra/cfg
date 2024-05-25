{
  lib,
  pkgs,
  ...
}: {
  programs.neovim.plugins = lib.attrValues {
    inherit
      (pkgs.vimPlugins)
      coc-json
      ;
  };
}
