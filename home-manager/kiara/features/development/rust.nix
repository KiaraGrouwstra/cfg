{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    coc-rls
    coc-rust-analyzer
  ];
}
