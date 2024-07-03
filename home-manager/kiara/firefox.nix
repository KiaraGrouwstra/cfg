{
  pkgs,
  lib,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".mozilla"
    ".cache/mozilla"
  ];

  home.packages = lib.attrValues {
    inherit
      (pkgs)
      firefoxpwa
      ;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    nativeMessagingHosts = lib.attrValues {
      inherit
        (pkgs)
        firefoxpwa
        ;
    };
    profiles = {
      kiara = {
        # search = {
        #   # Whether to force replace the existing search configuration
        #   force = true;
        #   # The default search engine used in the address bar and search bar
        #   default = "Brave Search";
        #   # The default search engine used in the Private Browsing
        #   privateDefault = "Brave Search";
        #   # The order the search engines are listed in
        #   order = [ "Brave Search" ];
        #   # Attribute set of search engine configurations
        #   # engines = lib.mapAttrs (_: default {
        #   #   updateInterval = 24 * 60 * 60 * 1000; # every day
        #   # }) {
        #   #   # "Bing".metaData.hidden = true;
        #   #   "Brave Search" = {
        #   #     urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
        #   #     iconUpdateURL = "https://brave.com/static-assets/images/cropped-brave_appicon_release-32x32.png";
        #   #     definedAliases = [ "@b" ];
        #   #   };
        #   #   "Nixpkgs-Package Search" = {
        #   #     urls = [{ template = "https://search.nixos.org/packages?channel=unstable&size=250&sort=relevance&type=packages&query={searchTerms}"; }];
        #   #     iconUpdateURL = "https://nixos.org/favicon.png";
        #   #     definedAliases = [ "@nps" ];
        #   #   };
        #   #   "Nixpkgs-Modules Search" = {
        #   #     urls = [{ template = "https://search.nixos.org/options?channel=unstable&size=200&sort=relevance&query={searchTerms}"; }];
        #   #     iconUpdateURL = "https://nixos.org/favicon.png";
        #   #     definedAliases = [ "@nms" ];
        #   #   };
        #   #   "NixOS-Wiki Search" = {
        #   #     urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}&go=Go"; }];
        #   #     iconUpdateURL = "https://nixos.org/favicon.png";
        #   #     definedAliases = [ "@nws" ];
        #   #   };
        #   #   "Home-Manager Search" = {
        #   #     urls = [{ template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}"; }];
        #   #     iconUpdateURL = "https://nixos.org/favicon.png";
        #   #     definedAliases = [ "@hms" ];
        #   #   };
        #   #   "GitHub-Code Search" = {
        #   #     urls = [{ template = "https://github.com/search?q={searchTerms}&type=code"; }];
        #   #     iconUpdateURL = "https://github.githubassets.com/favicons/favicon-dark.svg";
        #   #     definedAliases = [ "@gcs" ];
        #   #   };
        #   #   "Noogle.dev Search" = {
        #   #     urls = [{ template = "https://noogle.dev/?term=%22{searchTerms}%22"; }];
        #   #     iconUpdateURL = "https://noogle.dev/favicon.png";
        #   #     definedAliases = [ "@ngd" "@nog" ];
        #   #   };
        #   #   "Autonomous-System-Number Search" = {
        #   #     urls = [{ template = "https://bgp.tools/search?q={searchTerms}"; }];
        #   #     iconUpdateURL = "https://bgp.tools/favicon-32x32.png";
        #   #     definedAliases = [ "@asn" ];
        #   #   };
        #   #   "Nixpkgs PRs" = {
        #   #     urls = [{ template = "https://nixpk.gs/pr-tracker.html?pr={searchTerms}"; }];
        #   #     iconUpdateURL = "https://nixos.org/favicon.png";
        #   #     definedAliases = [ "@npr" ];
        #   #   };
        #   #   "Request for Comments" = {
        #   #     urls = [{ template = "https://datatracker.ietf.org/doc/html/rfc{searchTerms}"; }];
        #   #     iconUpdateURL = "https://www.ietf.org/favicon.ico";
        #   #     definedAliases = [ "@rfc" ];
        #   #   };
        #   #   "Way Back Machine" = {
        #   #     urls = [{ template = "	https://web.archive.org/web/*/{searchTerms}"; }];
        #   #     iconUpdateURL = "https://archive.org/favicon.ico";
        #   #     definedAliases = [ "@wbm" ];
        #   #   };
        #   # };
        # };
        # Preloaded bookmarks
        # bookmarks = [
        #   {
        #     name = "wikipedia";
        #     tags = [ "wiki" ];
        #     keyword = "wiki";
        #     url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&amp;go=Go";
        #   }
        #   {
        #     name = "kernel.org";
        #     url = "https://www.kernel.org";
        #   }
        #   {
        #     name = "Nix sites";
        #     toolbar = true;
        #     bookmarks = [
        #       {
        #         name = "homepage";
        #         url = "https://nixos.org/";
        #       }
        #       {
        #         name = "wiki";
        #         tags = [ "wiki" "nix" ];
        #         url = "https://wiki.nixos.org/";
        #       }
        #     ];
        #   }
        # ];
        # Attribute set of container configurations
        containers = {};
        # List of Firefox add-on packages to install for this profile
        # https://nur.nix-community.org/repos/rycee/
        extensions = let
          addons = pkgs.nur.repos.rycee.firefox-addons;
        in
          (lib.attrValues {
            inherit
              (addons)
              ublock-origin
              vimium-c
              violentmonkey
              keepassxc-browser
              # darkreader
              
              browserpass
              firefox-color
              stylus
              pywalfox
              no-pdf-download
              clearurls
              tabliss
              istilldontcareaboutcookies
              ;
          })
          ++ [
            (addons.buildFirefoxXpiAddon {
              pname = "dark-background-light-text-extension";
              version = "0.7.6";
              addonId = "jid1-QoFqdK4qzUfGWQ@jetpack";
              url = "https://addons.mozilla.org/firefox/downloads/file/3722915/dark-background-light-text-0.7.6.xpi";
              sha256 = "sha256-GCHbjrf7eRDKPi732ig6IwDgWjmMDoxYdj4CJtp9zVs=";
              meta = {
                homepage = "https://github.com/m-khvoinitsky/dark-background-light-text-extension";
                description = ''
                  Firefox addon that turns every page colors into "light text on dark background"'';
                license = lib.licenses.mpl20;
                mozPermissions = ["activeTab" "menus" "storage" "tabs"];
                platforms = lib.platforms.all;
              };
            })
          ];
        # Extra preferences to add to user.js
        extraConfig = "";
        # Profile ID
        id = 0;
        # Whether this is a default profile
        isDefault = true;
        # Profile name
        name = "kiara";
        # Profile path
        # path = "‹name›";
        # Attribute set of Firefox preferences
        settings = {
          "browser.startup.homepage" = null;
          "browser.search.region" = "NL";
          "browser.search.isUS" = false;
          "distribution.searchplugins.defaultLocale" = "en-US";
          "general.useragent.locale" = "en-US";
          "browser.bookmarks.showMobileBookmarks" = true;
          "browser.newtabpage.pinned" = [
            # {
            #   title = "NixOS";
            #   url = "https://nixos.org";
            # }
          ];
        };
        # Custom Firefox user chrome CSS
        userChrome = ''
          /* Hide tab bar in FF Quantum */
          @-moz-document url("chrome://browser/content/browser.xul") {
            #TabsToolbar {
              visibility: collapse !important;
              margin-bottom: 21px !important;
            }

            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
              visibility: collapse !important;
            }
          }
        '';
        # Custom Firefox user content CSS
        userContent = ''
          /* Hide scrollbar in FF Quantum */
          *{scrollbar-width:none !important}
        '';
      };
    };
  };
}
