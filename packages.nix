# This file defines packages packaged/customized in this repo
{
  inputs,
  lib,
  pkgs,
  ...
}: let
  # custom packages from the 'pkgs' directory
  additions = import ./pkgs {inherit pkgs inputs lib;};
  # customized packages from the 'overlays' directory
  modifications = import ./overlays {inherit pkgs lib;};
  scripts =
    lib.genAttrs
    lib.scripts.sh
    (name:
      pkgs.stdenv.mkDerivation {
        inherit name;
        pname = name;
        meta.mainProgram = name;
        src = ./scripts;
        executable = true;
        dontPatchShebangs = true;
        installPhase = ''
          mkdir -p $out/bin/
          cp $src/${name}.sh $out/bin/${name}
        '';
      });
in
  additions // modifications // scripts
