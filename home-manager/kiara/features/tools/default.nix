{pkgs, ...}: {
  home.packages = with pkgs; [
    ## terminals
    kitty
    wezterm

    ## command-line utilities
    zsh
    tealdeer
    thefuck
    jaq
    pandoc # lesspipe
    gum

    ## command-line dropins (ish)
    xxh
    bat
    ripgrep
    eza
    fd

    ## networking
    networkmanager_dmenu

    ## credentials / security
    pass
    keepassxc
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
      ];
    };

    # argument completer
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };

    browserpass = {
      # enable = true;  # Error installing file '.mozilla/native-messaging-hosts/com.github.browserpass.native.json' outside $HOME
      browsers = ["firefox"];
    };
  };

  ## credentials / security

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";
  };
}
