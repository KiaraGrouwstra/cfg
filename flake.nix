# nixos-rebuild switch will read its configuration from /etc/nixos/flake.nix if it is present.

{
  description = "kiara's nix config";

  inputs = {
    # Flake inputs
    flake-compat = {
      url = "github:edolstra/flake-compat";
    };
    nix = {
      url = "github:nixos/nix";
      inputs.flake-compat.follows = "flake-compat";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-software-center = {
      url = "github:vlinkz/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
    nixos-conf-editor = {
      url = "github:vlinkz/nixos-conf-editor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.snowfall-lib.follows = "snowfall-lib";
    };
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils-plus.follows = "flake-utils-plus";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    unbound-blocklist = {
      url = "github:mirosval/unbound-blocklist";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixos";
      inputs.utils.follows = "flake-utils";
    };
    catppuccin-vsc = {
      url = "github:catppuccin/vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # export HCLOUD_TOKEN="..."
    # nomad var put secrets/hcloud hcloud_token=$HCLOUD_TOKEN
    hcloud-csi-driver = {
      url = "github:hetznercloud/csi-driver";
      flake = false;
    };
    # there's a few drivers actually...
    # After booting, register the contents of the Nix store in the container in the Nix database in the tmpfs
    nomad-driver-nix = {
      url = "github:KiaraGrouwstra/nomad-driver-nix";
      inputs.nix.follows = "nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
    # A Nomad driver to run Nix jobs. Uses the same isolation mechanism as the exec driver. Partially based on nomad-driver-nix
    nomad-driver-nix2 = {
      url = "git+https://git.deuxfleurs.fr/Deuxfleurs/nomad-driver-nix2";
      flake = false;
    };
    # https://github.com/MagicRB/nomad-driver-containerd-nix
    nomad-driver-containerd-nix = {
      url = "github:MagicRB/nomad-driver-containerd-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, nur, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
      ];
      x86 = { system = "x86_64-linux"; };
      hammer = x86;
      lib = nixpkgs.lib // home-manager.lib // (import ./lib { inherit (nixpkgs) lib; });
      # { default: overlay }
      overlaysAttrs = import ./overlays.nix { inherit inputs lib; };
      # [ overlay ]
      overlays = builtins.attrValues overlaysAttrs ++ [
        nur.overlay
        # inputs.nix-vscode-extensions.overlays.default
        inputs.catppuccin-vsc.overlays.default
      ];
      # for each system: nixpkgs
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system overlays;
      });
      # for each system: apply pkgs to a function
      forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
      # Your custom packages, acessible through 'nix build', 'nix shell', etc
      # for each system: packages including overlays
      packages = forAllSystems (pkgs: import ./packages.nix { inherit inputs lib pkgs; });
    in
    {
      inherit lib packages;

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      imports = [
        ./cachix.nix
      ];

      # Devshell for bootstrapping
      # Acessible through 'nix develop -c $SHELL' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = overlaysAttrs;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {

        kiara-hammer = with hammer; nixpkgs.lib.nixosSystem {
          specialArgs = { inherit lib inputs outputs; };
          inherit system;
          modules = [
            "${builtins.getEnv "PWD"}/toggles/hosts/toggles.nix"
            nur.nixosModules.nur
            { nixpkgs = { inherit overlays; }; }
            ./hosts/hammer/configuration.nix
            nixos-hardware.nixosModules.lenovo-ideapad-slim-5
          ];
        };

      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {

        "kiara@hammer" = with hammer; lib.homeManagerConfiguration {
          pkgs = pkgsFor.${system};
          extraSpecialArgs = { inherit lib inputs outputs;
            unfree = inputs.nixpkgs-unfree.legacyPackages.${system};
          };
          modules = [
            "${builtins.getEnv "PWD"}/toggles/home-manager/toggles.nix"
            nur.nixosModules.nur
            ./home-manager/kiara/home.nix
            inputs.flake-programs-sqlite.nixosModules.programs-sqlite  # command-not-found
          ];
        };

      };
    };
}
