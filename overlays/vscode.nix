{ pkgs, ... }:

pkgs.vscode.override { commandLineArgs = "--ozone-platform=wayland"; }
