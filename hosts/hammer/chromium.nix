{ pkgs, ... }:

{

  programs.chromium = {
    enable = true;
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://search.brave.com/search?q={searchTerms}";
    defaultSearchProviderSuggestURL = null;
    homepageLocation = null;
    # https://chrome.google.com/webstore/category/extensions
    extensions = [
    ];
    # https://cloud.google.com/docs/chrome-enterprise/policies/
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-US"
        "nl"
      ];
    };
  };

}
