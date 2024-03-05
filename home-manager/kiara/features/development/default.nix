{pkgs, ...}: {
  imports = [
    # ./ansible.nix
    ./bash.nix
    ./docker.nix
    ./css.nix
    ./git.nix
    ./go.nix
    # ./haskell.nix
    ./hcl.nix
    ./html.nix
    # ./java.nix
    # ./javascript.nix
    # ./just.nix
    ./json.nix
    # ./kotlin.nix
    # ./idris.nix
    # ./latex.nix
    # ./scala.nix
    ./markdown.nix
    ./nix.nix
    # ./org.nix
    ./python.nix
    ./rust.nix
    ./sh.nix
    ./toml.nix
    ./typescript.nix
    ./vim.nix
    ./yaml.nix
  ];
  home.packages = with pkgs; [
    ## development
    direnv
    treefmt

    ## version control
    git
    git-crypt # sudo ln -s $(which git-crypt) /usr/bin/git-crypt
    git-interactive-rebase-tool
    gitg
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    mise = {
      enable = true;
      globalConfig = {
        tools = {
          # node = "lts";
          # python = [ "3.10" "3.11" ];
        };
      };
      settings = {
        verbose = false;
        experimental = true;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      # https://github.com/topics/gh-extension
      extensions = with pkgs; [gh-dash gh-markdown-preview];
      settings = {
        version = 1;
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
