{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
  ];
  programs.neovim.plugins = [pkgs.vimPlugins.coc-docker];
}
