{ pkgs, inputs, config, lib, ... }:

{

  imports = [ inputs.anyrun.homeManagerModules.default ];

  home.file = lib.listToAttrs (lib.lists.map (k: {
      name = ".config/anyrun/plugins/lib${k}.so";
      value = { source = "${inputs.anyrun.packages.${pkgs.system}.${k}}/lib/lib${k}.so"; };
    }) [
      "applications"
      "symbols"
      "rink"
      "shell"
      "translate"
      "kidex"
      "randr"
      "stdin"
      "dictionary"
      "websearch"
    ]);

  programs.anyrun = {
    enable = true;

    # https://github.com/Kirottu/anyrun/blob/master/examples/config.ron
    config = {
      # https://github.com/Kirottu/anyrun#plugins
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        symbols
        rink
        shell
        translate # uses google
        kidex
        randr
        stdin
        dictionary
        websearch # https://github.com/Kirottu/anyrun/blob/master/plugins/websearch/README.md
      ];

      # Position/size fields use an enum for the value, it can be either:
      # Absolute(n): The absolute value in pixels
      # Fraction(n): A fraction of the width or height of the full screen (depends on exclusive zones and the settings related to them) window respectively

      # The horizontal position, adjusted so that Relative(0.5) always centers the runner
      x.fraction = 0.5;
      # The vertical position, works the same as `x`
      y.absolute = 15;

      # The width of the runner
      width.fraction = 0.6;

      # The minimum height of the runner, the runner will expand to fit all the entries
      height.absolute = 0;

      # Hide match and plugin info icons
      hideIcons = false;

      # ignore exclusive zones, f.e. Waybar
      ignoreExclusiveZones = false;

      # Layer shell layer: Background, Bottom, Top, Overlay
      layer = "overlay";

      # Hide the plugin info panel
      hidePluginInfo = false;

      # Close window when a click outside the main box is received
      closeOnClick = true;

      # Show search results immediately when Anyrun starts
      showResultsImmediately = true;

      # Limit amount of entries shown in total
      # numbers seem to work while `null` seems overridden
      maxEntries = 100;

    };

    extraCss = builtins.readFile ./style-dark.css;

    # will be put in ~/.config/anyrun/some-plugin.ron
    # refer to docs of xdg.configFile for available options
    extraConfigFiles = {

      # https://github.com/Kirottu/anyrun/blob/master/plugins/applications/README.md
      "applications.ron".text = ''
        Config(
          max_entries: 100,
          // Also show the Desktop Actions defined in the desktop files, e.g. "New Window" from LibreWolf
          desktop_actions: false,
          terminal: Some("wezterm"),
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/symbols/README.md
      "symbols.ron".text = ''
        Config(
          max_entries: 100,
          // The prefix that the search needs to begin with to yield symbol results
          prefix: "",
          // Custom user defined symbols to be included along the unicode symbols
          symbols: {
            // "name": "text to be copied"
            "shrug": "¯\\_(ツ)_/¯",
          },
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/rink/README.md
      "rink.ron".text = ''
        Config(
          max_entries: 100,
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/shell/README.md
      "shell.ron".text = ''
        Config(
          max_entries: 100,
          prefix: ":sh",
          // Override the shell used to launch the command
          shell: Some("kitty"),
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/translate/README.md
      "translate.ron".text = ''
        Config(
          max_entries: 100,
          prefix: ":",
          language_delimiter: ">",
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/kidex/README.md
      "kidex.ron".text = ''
        Config(
          max_entries: 100,
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/randr/README.md
      "randr.ron".text = ''
        Config(
          max_entries: 100,
          prefix: ":dp",
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/stdin/README.md
      "stdin.ron".text = ''
        Config(
          max_entries: 100,
          allow_invalid: false,
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/dictionary/README.md
      "dictionary.ron".text = ''
        Config(
          max_entries: 100,
          prefix: ":def",
        )
      '';

      # https://github.com/Kirottu/anyrun/blob/master/plugins/websearch/README.md
      "websearch.ron".text = ''
        Config(
          max_entries: 100,
          prefix: "?",
          // Options: Google, Ecosia, Bing, DuckDuckGo, Custom
          //
          // Custom engines can be defined as such:
          // Custom(
          //   name: "Searx",
          //   url: "searx.be/?q={}",
          // )
          //
          // NOTE: `{}` is replaced by the search query and `https://` is automatically added in front.
          engines: [DuckDuckGo]
        )
      '';

    };

  };
}
