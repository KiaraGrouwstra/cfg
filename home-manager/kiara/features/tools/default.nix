{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./khal.nix
    ./khard.nix
    ./lazygit.nix
    ./nushell.nix
    ./vdirsyncer.nix
  ];
  home.persistence."/persist/home/kiara" = {
    directories = [
      ".config/keepassxc"
      ".config/thefuck"
      ".cache/keepassxc"
      ".cache/tealdeer"
      ".local/share/zoxide"
    ];
  };

  home.packages =
    [

      ## credentials / security
      (pkgs.pass.withExtensions (exts:
        lib.attrValues {
          inherit
            (exts)
            pass-otp
            pass-import
            pass-genphrase
            pass-checkup
            pass-update
            ;
        }))
    ]
    ++ lib.attrValues {
      inherit
        (pkgs)
        browserpass
        gnupg
        ## terminals
        
        kitty
        wezterm
        ## command-line utilities
        
        xdg-terminal-exec
        xterm-256color
        x-terminal-emulator
        zsh
        thefuck
        pandoc # lesspipe
        docker-client
        arion
        ## command-line dropins (ish)
        
        xxh
        ripgrep
        fd
        just
        ;
    };

  programs = {
    ## command-line utilities

    command-not-found.enable = true;

    powerline-go = {
      enable = true;
      modules = [
        "ssh"
        "cwd"
        "perms"
        "git"
        "nix-shell"
        "jobs"
        "exit"
        "root"
        "vi-mode"
      ];
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = false;
      enableNushellIntegration = true;
    };

    tealdeer = {
      enable = true;
      # https://dbrgn.github.io/tealdeer/config.html
      settings = {
        updates.auto_update = true;
        display.use_pager = true;
      };
    };

    # z: cd but with memory
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    # argument completer
    carapace = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    browserpass = {
      enable = true;
      browsers = ["firefox"];
    };
  };

  ## credentials / security

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
