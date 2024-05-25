{pkgs, ...}: {
  home.packages = [
    pkgs.nodePackages.bash-language-server
  ];
}
