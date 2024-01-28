{ pkgs, ... }:

{

  programs.firefox = {
    enable = true;
    # https://search.nixos.org/packages?query=firefox
    package = pkgs.firefox-bin;
    # package = pkgs.mercury-browser;
    wrapperConfig = {};
    preferencesStatus = "clear";
    # about:config
    preferences = {};
    # https://mozilla.github.io/policy-templates/
    policies = {
      DisableFirefoxAccounts = false;
      DontCheckDefaultBrowser = true;
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
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
      };
    };
    languagePacks = [
      "en-US"
      "nl"
      "ja"
      "zh-CN"
    ];
    # https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig
    autoConfig = "";
    nativeMessagingHosts.packages = with pkgs; [
      # browserpass
    ];
  };

}
