{pkgs, ...}: {
  imports = [
    ./lazygit.nix
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

  home.packages = with pkgs; [
    ## terminals
    kitty
    wezterm

    ## command-line utilities
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

    ## credentials / security
    (pass.withExtensions (exts:
      with exts; [
        pass-otp
        pass-import
        pass-genphrase
        pass-checkup
        pass-update
      ]))
    browserpass
    gnupg
  ];

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
    };

    # argument completer
    carapace = {
      enable = true;
      enableZshIntegration = true;
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
