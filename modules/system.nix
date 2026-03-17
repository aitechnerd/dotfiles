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
      KeyRepeat = 2;
      InitialKeyRepeat = 25;
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

    # ── Screenshots ──
    screencapture = {
      location = "~/Screenshots";
      type = "png";
    };
  };

  # ── Nix garbage collection ──
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 3; Minute = 0; };  # weekly on Sunday 3am
    options = "--delete-older-than 5d";
  };

  # ── Daily brew upgrade ──
  launchd.agents.brew-upgrade = {
    serviceConfig = {
      Label = "com.user.brew-upgrade";
      ProgramArguments = [ "/opt/homebrew/bin/brew" "upgrade" ];
      StartCalendarInterval = [{ Hour = 2; Minute = 0; }];
      StandardOutPath = "/tmp/brew-upgrade.log";
      StandardErrorPath = "/tmp/brew-upgrade.log";
    };
  };

  # ── Post-activation ──
  system.activationScripts.postUserActivation.text = ''
    # Show ~/Library in Finder
    chflags nohidden ~/Library
    # Ensure Screenshots directory exists
    mkdir -p ~/Screenshots
    # Install AI Dev Team for Claude Code (one-time)
    if [ ! -d ~/.ai-team ]; then
      ${pkgs.git}/bin/git clone https://github.com/aitechnerd/ai-dev-team ~/.ai-team
      bash ~/.ai-team/install.sh global
    fi
  '';

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
    "com.apple.screencapture" = {
      show-thumbnail = false;
    };
    "com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.dock" = {
      no-bouncing = true;
      springboard-show-duration = 0.1;
      springboard-hide-duration = 0.1;
      springboard-page-duration = 0;
    };
  };
}
