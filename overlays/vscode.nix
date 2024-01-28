{ pkgs, ... }:

# get newer electron by vscode-insiders over vscodium as workaround to https://github.com/NixOS/nixpkgs/issues/237978
(pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
  src = (builtins.fetchTarball {
    url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
    sha256 = "0z3gir3zkswcyxg9l12j5ldhdyb0gvhssvwgal286af63pwj9c66";
  });
  version = "latest";

  buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
})
