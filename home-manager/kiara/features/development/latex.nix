{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-texlab
    coc-vimtex
  ];
}
