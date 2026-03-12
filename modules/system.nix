{ pkgs, ... }:

{
  system.defaults = {

    # ── Dock ──
    dock = {
      autohide = true;
      show-recents = false;
      tilesize = 36;
      mru-spaces = false;
    };

    # ── Finder ──
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
    };

    # ── Global ──
    NSGlobalDomain = {
      KeyRepeat = 1;
      InitialKeyRepeat = 10;
      ApplePressAndHoldEnabled = false;
      AppleInterfaceStyle = "Dark";
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

  # ── Disable Siri ──
  system.defaults.CustomUserPreferences = {
    "com.apple.assistant.support" = {
      "Assistant Enabled" = false;
    };
    "com.apple.Siri" = {
      StatusMenuVisible = false;
      VoiceTriggerEnabled = false;
    };
    "com.apple.assistant.backedup" = {
      "Use device speaker for TTS" = 0;
    };
  };

  # ── Touch ID for sudo ──
  security.pam.services.sudo_local.touchIdAuth = true;
}
