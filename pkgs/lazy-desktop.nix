# https://github.com/bobvanderlinden/nixos-config/blob/3b2a868001188062781b952d47d7964b86f3b814/packages/lazy-desktop/default.nix
{
  lib,
  stdenv,
  runCommand,
  nix-index,
  desktop-file-utils,
  inputs,
  ...
}:
let
  nix-index = inputs.nix-index-database.packages.${stdenv.system}.nix-index-with-db;
in
stdenv.mkDerivation {
  name = "lazy-desktop";
  buildInputs = [ nix-index desktop-file-utils ];
  dontUnpack = true;
  dontBuild = true;
  installPhase = ''
mkdir -p $out/share/applications
nix-locate \
  --top-level \
  --minimal \
  --regex \
  '/share/applications/.*\.desktop$' \
  | while read -r package
  do
    cat > $out/share/applications/"$package.desktop" << EOF
[Desktop Entry]
Version=1.0
Name=$package
Type=Application
Exec=nix run "nixpkgs#$package" -- %F
EOF
    desktop-file-validate $out/share/applications/"$package.desktop"
  done
  '';
  meta = {
    platforms = lib.platforms.all;
  };
}
