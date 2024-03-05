{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.typescript-language-server
  ];
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-tsserver
    coc-tslint
    coc-tslint-plugin
  ];
}
