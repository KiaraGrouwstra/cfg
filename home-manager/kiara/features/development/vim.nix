{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.nodePackages.vim-language-server
  ];
  programs.neovim.plugins = lib.attrValues {
    inherit
      (pkgs.vimPlugins)
      coc-vimlsp
      coc-nvim
      ;
  };
}
