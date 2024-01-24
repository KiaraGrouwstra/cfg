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
      inputs.nixpkgs.follows = "nixpkgs";
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
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
      ];
      x86 = { system = "x86_64-linux"; };
      hammer = x86;
      lib = nixpkgs.lib // home-manager.lib;
      forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
      });
    in
    {
      inherit lib;

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      imports = [
        ./cachix.nix
      ];

      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs inputs; }
      );
      # Devshell for bootstrapping
      # Acessible through 'nix develop -c $SHELL' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {

        kiara-hammer = with hammer; nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          inherit system;
          modules = [
            "${builtins.getEnv "PWD"}/toggles/hosts/toggles.nix"
            ./hosts/hammer/configuration.nix
            nixos-hardware.nixosModules.lenovo-ideapad-slim-5
          ];
        };

        kiara-steen = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [ ./hosts/steen/configuration.nix ];
        };

      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {

        "kiara@hammer" = with hammer; lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs outputs;
            unfree = inputs.nixpkgs-unfree.legacyPackages.${system};
          };
          modules = [
            "${builtins.getEnv "PWD"}/toggles/home-manager/toggles.nix"
            ./home-manager/kiara/home.nix
            inputs.flake-programs-sqlite.nixosModules.programs-sqlite  # command-not-found
          ];
        };

        "kiara@steen" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/kiara/home.nix
          ];
        };

      };
    };
}
