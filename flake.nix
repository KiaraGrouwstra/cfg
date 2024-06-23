# nixos-rebuild switch will read its configuration from /etc/nixos/flake.nix if it is present.
{
  description = "kiara's nix config";

  inputs = {
    # Flake inputs
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
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
      # inputs.crate2nix.follows = "crate2nix";
    };
    # crate2nix = {
    #   url = "github:nix-community/crate2nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-parts.follows = "flake-parts";
    #   inputs.flake-compat.follows = "flake-compat";
    #   inputs.devshell.follows = "devshell";
    #   inputs.crate2nix_stable.follows = "crate2nix";
    # };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi-mime = {
      url = "github:DreamMaoMao/mime.yazi";
      flake = false;
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    regression.url = "github:nixos/nixpkgs/23.11";
    stable.url = "github:nixos/nixpkgs/24.05";
    lime3ds.url = "github:arthsmn/nixpkgs/lime3ds";
    arion.url = "github:AkechiShiro/nixpkgs/arion-use-docker-compose-v2";
    workman-vim = {
      url = "gitlab:ajgrf/workman-vim-bindings";
      flake = false;
    };
    lix = {
      url = "git+https://git.lix.systems/lix-project/lix?ref=refs/tags/2.90-beta.1";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module?ref=refs/heads/nogit-urls";
      inputs.lix.follows = "lix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-schemas.url = "github:gvolpe/flake-schemas";
    ## nix client with schema support: see https://github.com/NixOS/nix/pull/8892
    nix-schema = {
      inputs.flake-schemas.follows = "flake-schemas";
      url = "github:DeterminateSystems/nix-src/flake-schemas";
    };
  };

  outputs = {
    self,
    lix-module,
    nixpkgs,
    home-manager,
    nur,
    nixos-hardware,
    disko,
    impermanence,
    sops-nix,
    nix-index-database,
    flake-programs-sqlite,
    niri,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    name = "kiara";
    lib =
      nixpkgs.lib
      // home-manager.lib
      // (import ./lib {inherit (nixpkgs) lib;});
    forSystem = f: let
      o = lib.genAttrs ["aarch64-linux" "i686-linux" "x86_64-linux"] f;
    in
      o
      // {
        default = o.x86_64-linux;
      };
    # { default: overlay }
    overlaysAttrs = import ./overlays.nix {inherit inputs lib;};
    # [ overlay ]
    overlays =
      builtins.attrValues overlaysAttrs
      ++ lib.lists.map (k: inputs."${k}".overlay) [
        "nur"
        "nixgl"
      ];
    # for each system: nixpkgs
    pkgsFor =
      forSystem
      (system:
        import ./packages.nix {
          inherit inputs lib;
          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
            config.allowNonSource = false;
          };
        });
    # for each system: apply pkgs to a function
    forAllSystems = f: forSystem (system: f pkgsFor.${system});
    # Your custom packages, acessible through 'nix build', 'nix shell', etc
    # for each system: packages including overlays
    packages =
      forAllSystems
      (pkgs: forSystem (system: pkgsFor.${system}));
    userConfig = {
      inherit name;
      home = "/home/${name}";
    };
    specialFor = forSystem (system:
      {
        inherit system lib inputs outputs userConfig;
        # pkgs = pkgsFor.${system};
      }
      // lib.mapVals (nixpkgs': nixpkgs'.legacyPackages.${system}) {
        inherit
          (inputs)
          unfree
          regression
          stable
          lime3ds
          arion
          ;
      });

    # Eval the treefmt modules from ./treefmt.nix
    treefmtEval =
      forAllSystems
      (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

    nixosModules = import ./modules/nixos;

    homeModules = [
      impermanence.nixosModules.home-manager.impermanence
      nur.nixosModules.nur
      sops-nix.homeManagerModules.sops
      nix-index-database.hmModules.nix-index
      stylix.homeManagerModules.stylix
      flake-programs-sqlite.nixosModules.programs-sqlite # command-not-found
      ./modules/home-manager
      ./home-manager/kiara/home.nix
    ];
  in {
    # This facilitates consuming my custom packages thru the flake
    inherit lib packages;

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = lib.mapVals import nixosModules;

    # for `nix fmt`
    formatter =
      forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

    # for `nix flake check`
    checks = forAllSystems (pkgs: {
      formatting = treefmtEval.${pkgs.system}.config.build.check self;
    });

    # Devshell for bootstrapping
    # Acessible through 'nix develop -c $SHELL' or 'nix-shell' (legacy)
    devShells = forAllSystems (pkgs: import ./shell.nix {inherit pkgs;});

    # Your custom packages and modifications, exported as overlays
    overlays = overlaysAttrs;

    schemas =
      inputs.flake-schemas.schemas
      // import ./lib/schemas.nix {inherit (inputs) flake-schemas;};

    # Allow partioning with `disko -f .#hammer`
    diskoConfigurations.hammer = import ./hosts/hammer/disko-config.nix;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .'
    nixosConfigurations = forSystem (
      system: inputs.stable.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit system lib inputs outputs userConfig;};
          modules = [
            lix-module.nixosModules.default
            disko.nixosModules.disko
            impermanence.nixosModule
            nur.nixosModules.nur
            nixos-hardware.nixosModules.lenovo-ideapad-slim-5
            niri.nixosModules.niri
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            ./cache.nix
            {imports = lib.attrValues nixosModules;}
            {nixpkgs = {inherit overlays;};}
            ./hosts/hammer/configuration.nix
            ./hosts/hammer/imports.nix
            {
              nixpkgs.config.allowUnfree = true;
              home-manager = {
                extraSpecialArgs = specialFor.${system};
                users.${name}.imports =
                  homeModules
                  ++ [
                    ./home-manager/kiara/niri.nix
                  ];
              };
            }
          ];
        }
    );

    # `nix run .`
    defaultPackage = forSystem (system: nixpkgs.legacyPackages.${system}.just);
    # defaultPackage = forSystem (system: home-manager.defaultPackage.${system});

    homeConfigurations = forSystem (system:
      home-manager.lib.homeManagerConfiguration {
        # inherit overlays;
        pkgs = pkgsFor.${system};
        extraSpecialArgs = specialFor.${system};
        modules = homeModules;
      });

    # Apps make it easy to run my scripts from the flake
    apps = forSystem (system: let
      pkgs = pkgsFor.${system};
    in {
      nix = {
        type = "app";
        program = "${pkgs.nix-schema}/bin/nix-schema";
      };
    });
  };
}
