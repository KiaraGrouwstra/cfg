# This file defines packages packaged/customized in this repo
{ inputs, lib, pkgs, ... }:

let
  # custom packages from the 'pkgs' directory
  additions     = import ./pkgs     { inherit pkgs inputs lib; };
  # customized packages from the 'overlays' directory
  modifications = import ./overlays { inherit pkgs lib; };
in
  additions // modifications
