{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.vim-language-server
  ];
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-vimlsp
    coc-nvim
  ];
}
