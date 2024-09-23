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
    nixos-hardware.url = "github:nixos/nixos-hardware?rev=3980e7816c99d9e4da7a7b762e5b294055b73b2f";  # unstable nixpkgs: no branch
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
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi-mime = {
      url = "git+https://gitee.com/DreamMaoMao/mime-ext.yazi.git";
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
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    regression.url = "github:nixos/nixpkgs/release-24.05";
    stable.url = "github:nixos/nixpkgs/release-24.05";
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
    nix-search = {
      url = "github:diamondburned/nix-search";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noshell = {
      url = "github:viperML/noshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hullcaster = {
      url = "github:gilcu3/hullcaster";
      inputs.nixpkgs.follows = "nixpkgs";
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
      o = lib.genAttrs ["aarch64-linux" "x86_64-linux"] f;
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
      # external overlays
      ++ lib.lists.map (k: inputs."${k}".overlay) [
        "nixgl"
        "nur"
      ];
    # for each system: nixpkgs
    pkgsFor =
      forSystem
      (system: let
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
      in
        pkgs
        // import ./packages.nix {
          inherit inputs lib pkgs;
        }
        );
    # for each system: apply pkgs to a function
    forAllSystems = f: forSystem (system: f pkgsFor.${system});
    # Your custom packages, accessible through 'nix build', 'nix shell', etc
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
        # pkgs = pkgsFor.${system};  # programs/k9s: attribute 'formats' missing
      }
      // lib.mapVals (nixpkgs': nixpkgs'.legacyPackages.${system}) {
        inherit
          (inputs)
          nixpkgs
          unfree
          regression
          stable
          unstable
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
    # Accessible through 'nix develop -c $SHELL' or 'nix-shell' (legacy)
    devShells = forAllSystems (pkgs: import ./shell.nix {inherit pkgs;});

    # Your custom packages and modifications, exported as overlays
    overlays = overlaysAttrs;

    schemas =
      inputs.flake-schemas.schemas
      // import ./lib/schemas.nix {inherit (inputs) flake-schemas;};

    # Allow partitioning with `disko -f .#hammer`
    diskoConfigurations.hammer = import ./hosts/hammer/disko-config.nix;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .'
    nixosConfigurations = forSystem (
      system:
        inputs.nixpkgs.lib.nixosSystem {
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
                    ./home-manager/kiara/waybar.nix
                  ];
              };
            }
          ];
        }
    );

    # `nix run .`
    defaultPackage = forSystem (system: nixpkgs.legacyPackages.${system}.just);
    # defaultPackage = forSystem (system: home-manager.defaultPackage.${system});

    homeConfigurations = let
      bySystem = forSystem (system:
      home-manager.lib.homeManagerConfiguration {
        # inherit overlays;
        pkgs = pkgsFor.${system};
        extraSpecialArgs = specialFor.${system};
        modules = homeModules;
      });
      in bySystem // {
        krost = bySystem.x86_64-linux // {
          imports = [
            ./home-manager/kiara/chromebook.nix
          ];
        };
      };

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
