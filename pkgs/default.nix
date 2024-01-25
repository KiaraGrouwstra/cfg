# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using `nix build .#example` or (legacy) `nix-build -A example`

{ inputs, lib, pkgs, ... }:

with pkgs; (


  # non-flakes
  {
  } // (

    # flakes
    with inputs;
    {
      inherit (nix-software-center.packages.${system}) nix-software-center;
      inherit (nixos-conf-editor  .packages.${system}) nixos-conf-editor;
    }

  )
)
