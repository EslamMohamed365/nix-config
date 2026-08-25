{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      AIControls = {
        Default = {
          Value = "blocked";
          Locked = true;
        };
      };
    };
    profiles.eslam = {
      id = 0;
      search = {
        force = true;
        default = "google";
        order = [
          "google"
          "Searchix"
        ];
        engines = {
          "Searchix" = {
            urls = [
              {
                template = "https://searchix.ovh/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://searchix.ovh/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [
              "@sx"
              "@searchix"
            ];
          };
          "google".metaData.hidden = false;
        };
      };
      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          bitwarden
          ublock-origin
          sponsorblock
          vimium
          youtube-shorts-block
        ];
      };
      settings = {
        "extensions.autoDisableScopes" = 0;

        "network.trr.mode" = 2;
        "network.trr.uri" = "https://dns.quad9.net/dns-query";
        "network.trr.custom_uri" = "https://dns.quad9.net/dns-query";

        "media.eme.enabled" = true;
        "media.eme.require-app-approval" = false;

        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.generation.enabled" = false;

        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;

        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.sanitize.sanitizeOnShutdown.enabled" = true;

        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
        "browser.ping-centre.telemetry" = false;
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        "extensions.pocket.enabled" = false;

        "browser.uidensity" = 1;
        "browser.compactmode.show" = true;
        "browser.tabs.warnOnClose" = false;
        "browser.tabs.warnOnCloseOtherTabs" = false;
        "browser.tabs.warnOnOpen" = false;
        "browser.quitShortcut.disabled" = true;
        "browser.disableResetPrompt" = true;
        "browser.shell.checkDefaultBrowser" = false;

        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.pocket" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        "general.smoothScroll" = true;
        "browser.tabs.unloadOnLowMemory" = true;
      };
    };
  };
}
