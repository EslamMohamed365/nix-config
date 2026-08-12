{ pkgs, inputs, ... }:
{
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
      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          ublock-origin
          stylus
          sponsorblock
          vimium
          youtube-shorts-block
        ];
      };
      settings = {
        "extensions.autoDisableScopes" = 0;
        # DRM (Widevine) for streaming sites
        "media.eme.enabled" = true;
        "media.eme.require-app-approval" = false;
        # Passwords
        "signon.rememberSignons" = true;
        # Privacy
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.sanitize.sanitizeOnShutdown.enabled" = true;

        # Telemetry and data collection
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
        "browser.ping-centre.telemetry" = false;
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        # Pocket
        "extensions.pocket.enabled" = false;

        # UI
        "browser.uidensity" = 1;
        "browser.compactmode.show" = true;
        "browser.tabs.warnOnClose" = false;
        "browser.tabs.warnOnCloseOtherTabs" = false;
        "browser.tabs.warnOnOpen" = false;
        "browser.quitShortcut.disabled" = true;
        "browser.disableResetPrompt" = true;
        "browser.shell.checkDefaultBrowser" = false;

        # Search and new tab
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.pocket" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        # Performance
        "general.smoothScroll" = true;
        "browser.tabs.unloadOnLowMemory" = true;
      };
    };
  };
}
