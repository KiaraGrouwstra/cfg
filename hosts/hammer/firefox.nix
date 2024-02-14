{ lib, pkgs, ... }:

{

  programs.firefox = {
    enable = true;
    # https://search.nixos.org/packages?query=firefox
    package = pkgs.firefox-bin;
    # package = pkgs.mercury-browser;
    wrapperConfig = { };
    preferencesStatus = "clear";
    # about:config
    preferences = {
      # disable sound when searching through a page
      "accessibility.typeaheadfind.enablesound" = false;
      # enable dark pdfjs theme
      "pdfjs.viewerCssTheme" = 2;
      # break restrictions on extensions
      "privacy.resistFingerprinting.block_mozAddonManager" = true;
      # "extensions.webextensions.restrictedDomains" = ""; # use only trusted extensions
      # enable userChrome.css
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
    # https://mozilla.github.io/policy-templates/
    policies = {
      AppAutoUpdate = false;
      CaptivePortal = false;
      Cookies = {
        AcceptThirdParty = "from-visited";
        ExpireAtSessionEnd = false; # true
        Locked = true;
        RejectTracker = true;
        Behavior = "reject-tracker";
        BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
      };
      DisableAppUpdate = true;
      DisableFirefoxAccounts = false;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableFormHistory = true; # false
      DisableMasterPasswordCreation = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSafeMode = false;
      DisableSecurityBypass = true;
      DisableSetDesktopBackground = true;
      DisableSystemAddonUpdate = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = false;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = false;
        # Exceptions = ["https://example.com"];
      };
      ExtensionUpdate = false;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      InstallAddonsPermission.Default = false;
      ManualAppUpdateOnly = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = true;
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
      SecurityDevices = {
        # Use a proxy module rather than `nixpkgs.config.firefox.smartcardSupport = true`
        "PKCS#11 Proxy Module" = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
      };
      SearchEngines = {
        Default = "duckduckgo";
        PreventInstalls = true;
      };
      SearchSuggestEnabled = false;
    };
    languagePacks = [ "en-US" "nl" "ja" "zh-CN" ];
    # https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig
    autoConfig = "";
    nativeMessagingHosts.packages = with pkgs;
      [
        # browserpass
      ];
  };

}
