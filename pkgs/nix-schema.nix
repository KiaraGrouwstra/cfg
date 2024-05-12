{inputs, config, system, ...}:

inputs.nix-schema.packages.${system}.nix.overrideAttrs (old: {
  doCheck = false;
  doInstallCheck = false;
  postInstall = old.postInstall + ''
    rm $out/bin/nix-*
    mv $out/bin/nix $out/bin/nix-schema
  '';
})
