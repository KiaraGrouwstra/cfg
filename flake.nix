# nixos-rebuild switch will read its configuration from /etc/nixos/flake.nix if it is present.

{
  description = "kiara's nix config";

  inputs = {
    # Flake inputs
    nix = {
      url = github:nixos/nix;
      inputs.nixpkgs.follows = "master";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "master";
    };
    nur.url = "github:nix-community/NUR";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nix-software-center = {
      url = "github:vlinkz/nix-software-center";
      inputs.nixpkgs.follows = "master";
      inputs.utils.follows = "flake-utils";
    };
    nixos-conf-editor = {
      url = "github:vlinkz/nixos-conf-editor";
      inputs.nixpkgs.follows = "master";
      inputs.utils.follows = "flake-utils";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "master";
      inputs.nixpkgs-stable.follows = "master";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    # Nixpkgs branches
    master.url = "github:nixos/nixpkgs/master";

    # Non Flakes

    nix-zsh-completions = {
      url = "github:nix-community/nix-zsh-completions";
      flake = false;
    };

    zsh-completions = {
      url = "github:zsh-users/zsh-completions";
      flake = false;
    };

    zsh-nix-shell = {
      url = "github:chisui/zsh-nix-shell";
      flake = false;
    };

    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };

    # Default branch
    nixpkgs.follows = "master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
      ];
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
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {

        kiara-hammer = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [
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

        "kiara@hammer" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/kiara/home.nix
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
