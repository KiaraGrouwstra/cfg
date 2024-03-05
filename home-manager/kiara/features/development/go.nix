{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-go
  ];
}
