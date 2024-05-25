{
  pkgs,
  lib,
  ...
}: {
  programs.neovim.plugins = lib.attrValues {
    inherit
      (pkgs.vimPlugins)
      coc-rls
      coc-rust-analyzer
      ;
  };
}
