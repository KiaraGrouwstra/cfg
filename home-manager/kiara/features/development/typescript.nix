{
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.nodePackages.typescript-language-server
  ];
  programs.neovim.plugins = lib.attrValues {
    inherit
      (pkgs.vimPlugins)
      coc-tsserver
      coc-tslint
      coc-tslint-plugin
      ;
  };
}
