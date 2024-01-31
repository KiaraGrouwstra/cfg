{ pkgs, lib }:

let
  vscode-utils = pkgs.vscode-utils;
in
{






















  "pkief"."material-icon-theme" = vscode-utils.extensionFromVscodeMarketplace {
    name = "material-icon-theme";
    publisher = "pkief";
    version = "4.33.0";
    sha256 = "1yg48sfpmq8mc110d5hikw177v4iw2w5lmmd34fjlff5kvk5q2j7";
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

  "hashicorp"."terraform" = vscode-utils.extensionFromVscodeMarketplace {
    name = "terraform";
    publisher = "hashicorp";
    version = "2.29.2024012316";
    sha256 = "1i29i5s0kjcanlzsh4xxrlrimi2dsxrmh84aazs429vmivs3xi43";
  };

  "rust-lang"."rust" = vscode-utils.extensionFromVscodeMarketplace {
    name = "rust";
    publisher = "rust-lang";
    version = "0.7.9";
    sha256 = "0asmr7c9jmik1047n359s9zmv2m7d0i8sixki4p02z7qzyrpxrfs";
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

  "haskell"."haskell" = vscode-utils.extensionFromVscodeMarketplace {
    name = "haskell";
    publisher = "haskell";
    version = "2.5.2";
    sha256 = "09pr3ya77ryj5n80k5srwaxmr0j77f6xp67w0kz324i6fhjd12bq";
  };

  "marp-team"."marp-vscode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "marp-vscode";
    publisher = "marp-team";
    version = "2.8.0";
    sha256 = "1rzmiz0026g0wkb3sq7mr60il0m9gsm8k9alhdbv8zwf0k9x3yf7";
  };

  "asvetliakov"."vscode-neovim" = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-neovim";
    publisher = "asvetliakov";
    version = "1.5.0";
    sha256 = "1glad9xmzq58jc7js8afjmqrxgd3rqm80fk528wv5kqcmn90bgk3";
  };

  "hashicorp"."hcl" = vscode-utils.extensionFromVscodeMarketplace {
    name = "hcl";
    publisher = "hashicorp";
    version = "0.3.2";
    sha256 = "0snjivxdhr3s0lqarrzdzkv2f4qv28plbr3s9zpx7nqqfs97f4bk";
  };

  "foam"."foam-vscode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "foam-vscode";
    publisher = "foam";
    version = "0.25.7";
    sha256 = "11za3jb47vrxwxy6mqmvf23amkz27sfhjxfzrchl57ygzw5d0q84";
  };

  "kahole"."magit" = vscode-utils.extensionFromVscodeMarketplace {
    name = "magit";
    publisher = "kahole";
    version = "0.6.59";
    sha256 = "068hsif9d91wd006zp4wq0zv3rzwjvm0za9wc8jl59h9ql0811m8";
  };

  "vscode-org-mode"."org-mode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "org-mode";
    publisher = "vscode-org-mode";
    version = "1.0.0";
    sha256 = "1dp6mz1rb8awrrpig1j8y6nyln0186gkmrflfr8hahaqr668il53";
  };

  "jnoortheen"."nix-ide" = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-ide";
    publisher = "jnoortheen";
    version = "0.2.2";
    sha256 = "1264027sjh9a112si0y0p3pk3y36shj5b4qkpsj207z7lbxqq0wg";
  };

  "arrterian"."nix-env-selector" = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "1.0.10";
    sha256 = "0gx2w0z4ibr46g4yqllqmyff779r272pd73ajxh55n8lpk8snx3g";
  };

  "mkhl"."direnv" = vscode-utils.extensionFromVscodeMarketplace {
    name = "direnv";
    publisher = "mkhl";
    version = "0.16.0";
    sha256 = "1jmwqbbh5x5z7dscgcn4pb0g41k7zlhgf5i8syl3ipv6z270aq5v";
  };

  "kokakiwi"."vscode-just" = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-just";
    publisher = "kokakiwi";
    version = "2.1.0";
    sha256 = "1mjj7h7d01afi3qcyflcwpi05a6n6m6ym07rz34m3mxma461cxyn";
  };

  "meraymond"."idris-vscode" = vscode-utils.extensionFromVscodeMarketplace {
    name = "idris-vscode";
    publisher = "meraymond";
    version = "0.0.14";
    sha256 = "0yam13n021lmc93m8rpw96ksci0jshfrlnnfdk1q9yqrxydy6320";
  };
}

