{ pkgs, ... }:

{
  system.defaults = {

    # ── Dock ──
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      show-recents = false;
      tilesize = 48;
      mru-spaces = false;
      launchanim = false;
      expose-animation-duration = 0.1;
      mineffect = "scale";
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
    };

    # ── Finder ──
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      CreateDesktop = false;
      QuitMenuItem = true;
    };

    # ── Global ──
    NSGlobalDomain = {
      KeyRepeat = 1;
      InitialKeyRepeat = 10;
      ApplePressAndHoldEnabled = false;
      AppleInterfaceStyle = "Dark";
      NSAutomaticWindowAnimationsEnabled = false;
      NSWindowResizeTime = 0.001;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
    };

    # ── Trackpad ──
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };

    # ── Login ──
    loginwindow.GuestEnabled = false;
  };

  # ── Touch ID for sudo ──
  security.pam.services.sudo_local.touchIdAuth = true;

  # ── Disable Siri & background resource hogs ──
  system.defaults.CustomUserPreferences = {
    "com.apple.assistant.support" = {
      "Assistant Enabled" = false;
    };
    "com.apple.Siri" = {
      StatusMenuVisible = false;
      VoiceTriggerEnabled = false;
      UserHasDeclinedEnable = true;
    };
    "com.apple.assistant.backedup" = {
      "Use device speaker for TTS" = 0;
    };
"com.apple.SoftwareUpdate" = {
      AutomaticDownload = false;
      AutomaticCheckEnabled = false;
    };
    "com.apple.commerce" = {
      AutoUpdate = false;
    };
    "com.apple.LaunchServices" = {
      LSQuarantine = false;
    };
    "com.apple.NetworkBrowser" = {
      DisableAirDrop = true;
    };
    "com.apple.CrashReporter" = {
      DialogType = "none";
    };
    "com.apple.photoanalysisd" = {
      PADisabled = true;
    };
    "com.apple.finder" = {
      DisableAllAnimations = true;
    };
    "com.apple.AdLib" = {
      allowApplePersonalizedAdvertising = false;
    };
    "com.apple.dock" = {
      no-bouncing = true;
      springboard-show-duration = 0.1;
      springboard-hide-duration = 0.1;
      springboard-page-duration = 0;
    };
  };
}
