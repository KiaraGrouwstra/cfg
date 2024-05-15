{
  pkgs,
  lib,
}: let
  inherit (pkgs.stdenv) isDarwin isLinux isi686 isx86_64 isAarch32 isAarch64;
  inherit (pkgs) vscode-utils;
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
          "esbenp"."prettier-vscode" = vscode-utils.extensionFromVscodeMarketplace {
            name = "prettier-vscode";
            publisher = "esbenp";
            version = "10.4.0";
            sha256 = "1iy7i0yxnhizz40llnc1dk9q8kk98rz6ki830sq7zj3ak9qp9vzk";
          };
          "ms-azuretools"."vscode-docker" = vscode-utils.extensionFromVscodeMarketplace {
            name = "vscode-docker";
            publisher = "ms-azuretools";
            version = "1.29.1";
            sha256 = "0zba6g0cw2h42gfvrlx0x2axlj61hkrfjfg5kyd14fqzi4n9jmxs";
          };
          "pkief"."material-icon-theme" = vscode-utils.extensionFromVscodeMarketplace {
            name = "material-icon-theme";
            publisher = "pkief";
            version = "5.3.0";
            sha256 = "1gpbnwmqw0mxa6ald73ir44diyvlz4r8dar3jb5f9jqlmak92a28";
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
            version = "0.55.0";
            sha256 = "00rx55aapb7w6wazc3kyl8gzvfyr5d0flrwgxfz1pffw2dywfmxj";
          };
          "mikestead"."dotenv" = vscode-utils.extensionFromVscodeMarketplace {
            name = "dotenv";
            publisher = "mikestead";
            version = "1.0.1";
            sha256 = "0rs57csczwx6wrs99c442qpf6vllv2fby37f3a9rhwc8sg6849vn";
          };
          "ms-python"."black-formatter" = vscode-utils.extensionFromVscodeMarketplace {
            name = "black-formatter";
            publisher = "ms-python";
            version = "2024.2.0";
            sha256 = "14w1ix8pm924piyw0dx2rq27cm5kmps9q99mkwrhi3ypliibx0x8";
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
            version = "190.3.0";
            sha256 = "15m2cdn0a1dnqbik1apih7k8kbhmy0ha39x96lhics3kp2541klq";
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
            version = "0.5.0";
            sha256 = "1qq450ix0xhz0llf620hphmdf1r98ngyri1bay1q4k4cj1497z09";
          };
          "trond-snekvik"."simple-rst" = vscode-utils.extensionFromVscodeMarketplace {
            name = "simple-rst";
            publisher = "trond-snekvik";
            version = "1.5.4";
            sha256 = "1js1489nd9fycvpgh39mwzpbqm28qi4gzi68443v3vhw3dsg4wjv";
          };
          "ms-python"."mypy-type-checker" = vscode-utils.extensionFromVscodeMarketplace {
            name = "mypy-type-checker";
            publisher = "ms-python";
            version = "2023.9.11361013";
            sha256 = "14wl2k2n338jwz2jhrg0h65nsvx1hxy1dxka8dr909xv3valj9s2";
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
          "mkhl"."direnv" = vscode-utils.extensionFromVscodeMarketplace {
            name = "direnv";
            publisher = "mkhl";
            version = "0.17.0";
            sha256 = "1n2qdd1rspy6ar03yw7g7zy3yjg9j1xb5xa4v2q12b0y6dymrhgn";
          };
          "arrterian"."nix-env-selector" = vscode-utils.extensionFromVscodeMarketplace {
            name = "nix-env-selector";
            publisher = "arrterian";
            version = "1.0.11";
            sha256 = "113zx78c3219knw4qa04242404n32vnk9rb6a3ynz41dgwh1mbbl";
          };
          "swyddfa"."esbonio" = vscode-utils.extensionFromVscodeMarketplace {
            name = "esbonio";
            publisher = "swyddfa";
            version = "0.94.0";
            sha256 = "1jdsf17f6x3napbx8nlmziy43z70ihjmm0k7k4adiq9gwzjd7jbm";
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
            version = "0.4.1960";
            sha256 = "0gxgzjj87cqxdx0g0v8wik3ph4pzp9my5ba0j25xiccma9gir722";
            arch = "linux-x64";
          };
          "charliermarsh"."ruff" = vscode-utils.extensionFromVscodeMarketplace {
            name = "ruff";
            publisher = "charliermarsh";
            version = "2024.21.11161840";
            sha256 = "068r3915nn7wc2w7ilhsjip488zl8aw9d951sy6nac86hrh7ldgz";
            arch = "linux-x64";
          };
          "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
            name = "continue";
            publisher = "continue";
            version = "0.9.132";
            sha256 = "1m26hpa1wpf1wxbg272slyc1rdp709vbnx624vnri3wcnl7kf7ab";
            arch = "linux-x64";
          };
        }))
      (lib.attrsets.optionalAttrs (isLinux && (isAarch32 || isAarch64)) {
        "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
          name = "rust-analyzer";
          publisher = "rust-lang";
          version = "0.4.1960";
          sha256 = "1ibz3599ypqzv85rsscfajvmiv6w8xzavjyk9nq0q6a47zjk2qgh";
          arch = "linux-arm64";
        };
        "charliermarsh"."ruff" = vscode-utils.extensionFromVscodeMarketplace {
          name = "ruff";
          publisher = "charliermarsh";
          version = "2024.21.11161840";
          sha256 = "0zrwf7xcj4i1wncqiwgiycbrnl6z4s37vfl6x2in4clc8ayla4ys";
          arch = "linux-arm64";
        };
        "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
          name = "continue";
          publisher = "continue";
          version = "0.9.132";
          sha256 = "1ryx90micas5asdkblqfi65az0mkbwjzyxl84z12ibvxvzi8fvpa";
          arch = "linux-arm64";
        };
      }))
    (lib.attrsets.optionalAttrs (isDarwin && (isi686 || isx86_64)) {
      "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
        name = "rust-analyzer";
        publisher = "rust-lang";
        version = "0.4.1960";
        sha256 = "02rxx31zmv9cblmb0iiy6cafhn1fjmvbg58zq0713hgvfky0kkyj";
        arch = "darwin-x64";
      };
      "charliermarsh"."ruff" = vscode-utils.extensionFromVscodeMarketplace {
        name = "ruff";
        publisher = "charliermarsh";
        version = "2024.21.11161840";
        sha256 = "16pygc1jai43bsyjb9fwng6h26x12gfkplnf7jv7hbdc35cih5yy";
        arch = "darwin-x64";
      };
      "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
        name = "continue";
        publisher = "continue";
        version = "0.9.132";
        sha256 = "0bshzc982k6g2flrhcqr1cahv0850yj8hzcza482wzkic4q8zqmf";
        arch = "darwin-x64";
      };
    }))
  (lib.attrsets.optionalAttrs (isDarwin && (isAarch32 || isAarch64)) {
    "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
      name = "rust-analyzer";
      publisher = "rust-lang";
      version = "0.4.1960";
      sha256 = "0vm7pjka38cinzpa8f2rnrnyp45jk1gxwz6y5v8axqg1c76gzl6m";
      arch = "darwin-arm64";
    };
    "charliermarsh"."ruff" = vscode-utils.extensionFromVscodeMarketplace {
      name = "ruff";
      publisher = "charliermarsh";
      version = "2024.21.11161840";
      sha256 = "1j3g5m3kr4hxvqfvp0ji6kwsp8fgay9lwycn3hljca9xx8mfn6dz";
      arch = "darwin-arm64";
    };
    "continue"."continue" = vscode-utils.extensionFromVscodeMarketplace {
      name = "continue";
      publisher = "continue";
      version = "0.9.132";
      sha256 = "1sgid1f77b9rmi63hxlyi2v8jpa9cki2rmw8g2ky6kj50sk5gill";
      arch = "darwin-arm64";
    };
  })
