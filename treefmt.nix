{pkgs, ...}: {
  projectRootFile = "flake.nix";
  programs.alejandra.enable = true;
  programs.statix.enable = true;
}
