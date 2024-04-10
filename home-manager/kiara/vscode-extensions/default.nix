{ pkgs, lib }:

let
  inherit (pkgs.stdenv) isDarwin isLinux isi686 isx86_64 isAarch32 isAarch64;
  vscode-utils = pkgs.vscode-utils;
  merge = lib.attrsets.recursiveUpdate;
in
merge
  (merge
    (merge
      (merge
      {
  "ms-python"."python" = vscode-utils.extensionFromVscodeMarketplace {
    name = "python";
    publisher = "ms-python";
    version = "2024.3.10742127";
    sha256 = "187x6j7300wgvcxh2lcic6ivvavsllzhq0cayqiji943pw3z3k2r";
  };

  "pkief"."material-icon-theme" = vscode-utils.extensionFromVscodeMarketplace {
    name = "material-icon-theme";
    publisher = "pkief";
    version = "4.34.0";
    sha256 = "1ahshxw66436mc9jpiyfac0hinnqm3s0g3akybjrda13yd9884y7";
  };

  "redhat"."vscode-yaml" = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-yaml";
    publisher = "redhat";
    version = "1.14.0";
    sha256 = "0pww9qndd2vsizsibjsvscz9fbfx8srrj67x4vhmwr581q674944";
  };

  "editorconfig"."editorconfig" = vscode-utils.extensionFromVscodeMarketplace {
    name = "editorconfig";
    publisher = "editorconfig";
    version = "0.16.4";
    sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
  };
  "davidanson"."vscode-markdownlint" = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-markdownlint";
    publisher = "davidanson";
    version = "0.54.0";
    sha256 = "171qw6mymc9hmm8xin3gwr8r2ac8yfr3s8agagsqq9193cawbcq6";
  };
  "mikestead"."dotenv" = vscode-utils.extensionFromVscodeMarketplace {
    name = "dotenv";
    publisher = "mikestead";
    version = "1.0.1";
    sha256 = "0rs57csczwx6wrs99c442qpf6vllv2fby37f3a9rhwc8sg6849vn";
  };
  "tamasfe"."even-better-toml" = vscode-utils.extensionFromVscodeMarketplace {
    name = "even-better-toml";
    publisher = "tamasfe";
    version = "0.19.2";
    sha256 = "0q9z98i446cc8bw1h1mvrddn3dnpnm2gwmzwv2s3fxdni2ggma14";
  };
  "justusadam"."language-haskell" = vscode-utils.extensionFromVscodeMarketplace {
    name = "language-haskell";
    publisher = "justusadam";
    version = "3.6.0";
    sha256 = "115y86w6n2bi33g1xh6ipz92jz5797d3d00mr4k8dv5fz76d35dd";
  };
  "lextudio"."restructuredtext" = vscode-utils.extensionFromVscodeMarketplace {
    name = "restructuredtext";
    publisher = "lextudio";
    version = "190.1.20";
    sha256 = "13zqpkd0gk1xh1vpc5x3zzy4nlkyzr9ap7a95in9z2y5pk6hp8px";
  };
  "haskell"."haskell" = vscode-utils.extensionFromVscodeMarketplace {
    name = "haskell";
    publisher = "haskell";
    version = "2.5.2";
    sha256 = "09pr3ya77ryj5n80k5srwaxmr0j77f6xp67w0kz324i6fhjd12bq";
  };
  "asvetliakov"."vscode-neovim" = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-neovim";
    publisher = "asvetliakov";
    version = "1.7.1";
    sha256 = "0ib4sjk7r370ckvaqb4yzgy7csy8pli9z2jhibhhwwcq2748ah4q";
  };
  "marp-team"."marp-vscode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "marp-vscode";
    publisher = "marp-team";
    version = "2.8.0";
    sha256 = "1rzmiz0026g0wkb3sq7mr60il0m9gsm8k9alhdbv8zwf0k9x3yf7";
  };
  "hashicorp"."hcl" = vscode-utils.extensionFromVscodeMarketplace {
    name = "hcl";
    publisher = "hashicorp";
    version = "0.3.2";
    sha256 = "0snjivxdhr3s0lqarrzdzkv2f4qv28plbr3s9zpx7nqqfs97f4bk";
  };
  "trond-snekvik"."simple-rst" = vscode-utils.extensionFromVscodeMarketplace {
    name = "simple-rst";
    publisher = "trond-snekvik";
    version = "1.5.4";
    sha256 = "1js1489nd9fycvpgh39mwzpbqm28qi4gzi68443v3vhw3dsg4wjv";
  };
  "foam"."foam-vscode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "foam-vscode";
    publisher = "foam";
          version = "0.25.11";
          sha256 = "0g119534d712ddyfpbrz99da3hy218b0fa28l0qn713rpa3736ms";
  };
  "kahole"."magit" = vscode-utils.extensionFromVscodeMarketplace {
    name = "magit";
    publisher = "kahole";
          version = "0.6.61";
          sha256 = "10zayxkrmajk12qajggixv0ssrjlmwr1s58d3mz2wb93kb1gmmdn";
  };
  "jnoortheen"."nix-ide" = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-ide";
    publisher = "jnoortheen";
    version = "0.3.1";
    sha256 = "1cpfckh6zg8byi6x1llkdls24w9b0fvxx4qybi9zfcy5gc60r6nk";
  };
  "vscode-org-mode"."org-mode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "org-mode";
    publisher = "vscode-org-mode";
    version = "1.0.0";
    sha256 = "1dp6mz1rb8awrrpig1j8y6nyln0186gkmrflfr8hahaqr668il53";
  };
  "arrterian"."nix-env-selector" = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "1.0.11";
    sha256 = "113zx78c3219knw4qa04242404n32vnk9rb6a3ynz41dgwh1mbbl";
  };
  "mkhl"."direnv" = vscode-utils.extensionFromVscodeMarketplace {
    name = "direnv";
    publisher = "mkhl";
    version = "0.17.0";
    sha256 = "1n2qdd1rspy6ar03yw7g7zy3yjg9j1xb5xa4v2q12b0y6dymrhgn";
  };
  "swyddfa"."esbonio" = vscode-utils.extensionFromVscodeMarketplace {
    name = "esbonio";
    publisher = "swyddfa";
    version = "0.92.1";
    sha256 = "1d4y6hfbywgb04ib882159faws537fy4mb0yllskc0xh0426zljc";
  };
  "eww-yuck"."yuck" = vscode-utils.extensionFromVscodeMarketplace {
    name = "yuck";
    publisher = "eww-yuck";
    version = "0.0.3";
    sha256 = "1hxdxa13s1vlilw7fidr8vnl19c9wjazjvnvmqgl4fsswwny110c";
  };
  "kokakiwi"."vscode-just" = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-just";
    publisher = "kokakiwi";
    version = "2.1.0";
    sha256 = "1mjj7h7d01afi3qcyflcwpi05a6n6m6ym07rz34m3mxma461cxyn";
  };
  "kdl-org"."kdl" = vscode-utils.extensionFromVscodeMarketplace {
    name = "kdl";
    publisher = "kdl-org";
    version = "1.3.1";
    sha256 = "1a302y4xkqng5pbiyzxlr3mpl1r9g4813m14gzzjh6wsmj3z4rni";
  };
  "meraymond"."idris-vscode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "idris-vscode";
    publisher = "meraymond";
    version = "0.0.14";
    sha256 = "0yam13n021lmc93m8rpw96ksci0jshfrlnnfdk1q9yqrxydy6320";
  };
        "kamadorueda"."alejandra" = vscode-utils.extensionFromVscodeMarketplace {
          name = "alejandra";
          publisher = "kamadorueda";
          version = "1.0.0";
          sha256 = "1ncjzhrc27c3cwl2cblfjvfg23hdajasx8zkbnwx5wk6m2649s88";
        };
      }
        (lib.attrsets.optionalAttrs (isLinux && (isi686 || isx86_64)) {
          "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
            name = "rust-analyzer";
            publisher = "rust-lang";
            version = "0.4.1918";
            sha256 = "07par64zgifsfx7j9d5kp3rck2akny7908zw81286f2kajzmdsjy";
            arch = "linux-x64";
          };
        }))
      (lib.attrsets.optionalAttrs (isLinux && (isAarch32 || isAarch64)) {
        "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
          name = "rust-analyzer";
          publisher = "rust-lang";
          version = "0.4.1918";
          sha256 = "137x9463hr0c8xpn27pf3s55szafid7yg4lnri0wr631h75y2a23";
          arch = "linux-arm64";
        };
      }))
    (lib.attrsets.optionalAttrs (isDarwin && (isi686 || isx86_64)) {
      "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
        name = "rust-analyzer";
        publisher = "rust-lang";
        version = "0.4.1918";
        sha256 = "12sa0bk88bdvm07fqi91j5869hjp2gk6pg3h5d48va1z8y3mzmai";
        arch = "darwin-x64";
      };
    }))
  (lib.attrsets.optionalAttrs (isDarwin && (isAarch32 || isAarch64)) {
    "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
      name = "rust-analyzer";
      publisher = "rust-lang";
      version = "0.4.1918";
      sha256 = "05ix00za6vbh64abd3sgnr88p4aihamaps1ab2fjg7pi6qs4jz15";
      arch = "darwin-arm64";
    };
  })

