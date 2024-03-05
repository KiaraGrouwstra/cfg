{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-python
    coc-pyright
  ];
}
