# nixos-rebuild switch will read its configuration from /etc/nixos/flake.nix if it is present.
{
  description = "kiara's nix config";

  inputs = {
    # Flake inputs
    flake-compat.url = "github:edolstra/flake-compat";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
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
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.flake-compat.follows = "flake-compat";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixos";
      inputs.utils.follows = "flake-utils";
    };
    catppuccin-vsc = {
      url = "github:catppuccin/vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.crate2nix.follows = "crate2nix";
    };
    crate2nix = {
      url = "github:nix-community/crate2nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.flake-compat.follows = "flake-compat";
      inputs.devshell.follows = "devshell";
      inputs.crate2nix_stable.follows = "crate2nix";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flare = {
      url = "gitlab:schmiddi-on-mobile/flare";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    yazi-mime = {
      url = "github:DreamMaoMao/mime.yazi";
      flake = false;
    };
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = ["aarch64-linux" "i686-linux" "x86_64-linux"];
    x86 = {system = "x86_64-linux";};
    hammer = x86;
    lib =
      nixpkgs.lib
      // home-manager.lib
      // (import ./lib {inherit (nixpkgs) lib;});
    # { default: overlay }
    overlaysAttrs = import ./overlays.nix {inherit inputs lib;};
    # [ overlay ]
    overlays =
      builtins.attrValues overlaysAttrs
      ++ (with inputs; [
        nur.overlay
        catppuccin-vsc.overlays.default
      ]);
    # for each system: nixpkgs
    pkgsFor =
      lib.genAttrs systems
      (system:
        import nixpkgs {
          inherit system overlays;
          # config.allowUnfree = true;
        });
    # for each system: apply pkgs to a function
    forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
    # Your custom packages, acessible through 'nix build', 'nix shell', etc
    # for each system: packages including overlays
    packages =
      forAllSystems
      (pkgs: import ./packages.nix {inherit inputs lib pkgs;});

    # Eval the treefmt modules from ./treefmt.nix
    treefmtEval =
      forAllSystems
      (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in {
    inherit lib packages;

    # for `nix fmt`
    formatter =
      forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

    # for `nix flake check`
    checks = forAllSystems (pkgs: {
      formatting = treefmtEval.${pkgs.system}.config.build.check self;
    });

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Devshell for bootstrapping
    # Acessible through 'nix develop -c $SHELL' or 'nix-shell' (legacy)
    devShells = forAllSystems (pkgs: import ./shell.nix {inherit pkgs;});

    # Your custom packages and modifications, exported as overlays
    overlays = overlaysAttrs;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      hammer = with hammer; let
        specialArgs = {
          inherit lib inputs outputs;
          unfree = inputs.nixpkgs-unfree.legacyPackages.${system};
        };
      in
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = with inputs; [
            ./cachix.nix
            nur.nixosModules.nur
            {nixpkgs = {inherit overlays;};}
            ./hosts/hammer/configuration.nix
            nixos-hardware.nixosModules.lenovo-ideapad-slim-5
            niri.nixosModules.niri
            {
              home-manager = {
                extraSpecialArgs = specialArgs;
                users.kiara.imports = with inputs; [
                  nur.nixosModules.nur
                  inputs.sops-nix.homeManagerModules.sops
                  ./modules/home-manager
                  nix-index-database.hmModules.nix-index
                  stylix.homeManagerModules.stylix
                  ./home-manager/kiara/home.nix
                  flake-programs-sqlite.nixosModules.programs-sqlite # command-not-found
                ];
              };
            }
          ];
        };
    };
  };
}
