#!/bin/bash
# macOS system defaults — runs once per machine via chezmoi

set -euo pipefail

echo "Configuring macOS defaults..."

# ── Dock ──
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.0
defaults write com.apple.dock autohide-time-modifier -float 0.0
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.dock springboard-show-duration -float 0.1
defaults write com.apple.dock springboard-hide-duration -float 0.1
defaults write com.apple.dock springboard-page-duration -int 0
# Disable hot corners
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tr-corner -int 1
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-br-corner -int 1

# ── Finder ──
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder DisableAllAnimations -bool true

# ── Keyboard ──
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# ── Appearance ──
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# ── Animations ──
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# ── Text corrections (disable all) ──
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# ── Trackpad ──
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# ── Login ──
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# ── Screenshots ──
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture show-thumbnail -bool false

# ── Disable Siri ──
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.Siri VoiceTriggerEnabled -bool false
defaults write com.apple.Siri UserHasDeclinedEnable -bool true
defaults write com.apple.assistant.backedup "Use device speaker for TTS" -int 0

# ── Privacy & security ──
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false

# ── Disable photo analysis ──
defaults write com.apple.photoanalysisd PADisabled -bool true

# ── Disable .DS_Store on network/USB ──
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ── Show ~/Library in Finder ──
chflags nohidden ~/Library

# ── Touch ID for sudo ──
SUDO_LOCAL="/etc/pam.d/sudo_local"
if [ ! -f "$SUDO_LOCAL" ] || ! grep -q "pam_tid.so" "$SUDO_LOCAL"; then
    echo "auth       sufficient     pam_tid.so" | sudo tee "$SUDO_LOCAL" > /dev/null
    echo "Enabled Touch ID for sudo"
fi

# ── Nextcloud Documents symlink ──
if [ -d "${HOME}/Nextcloud/Documents" ] && [ ! -L "${HOME}/Documents" ]; then
    echo "Linking ~/Documents -> ~/Nextcloud/Documents"
    rm -rf "${HOME}/Documents"
    ln -s "${HOME}/Nextcloud/Documents" "${HOME}/Documents"
fi

# ── Install AI Dev Team for Claude Code ──
if [ ! -d ~/.ai-team ]; then
    git clone https://github.com/aitechnerd/ai-dev-team ~/.ai-team
    bash ~/.ai-team/install.sh global
fi

# ── Daily brew upgrade (9am, runs on wake if missed) ──
PLIST="$HOME/Library/LaunchAgents/com.user.brew-upgrade.plist"
mkdir -p "$HOME/Library/LaunchAgents"
cp "$HOME/.config/homebrew/brew-upgrade.plist" "$PLIST"
launchctl bootout gui/$(id -u) "$PLIST" 2>/dev/null || true
launchctl bootstrap gui/$(id -u) "$PLIST"

# ── Apply changes ──
killall Dock Finder SystemUIServer 2>/dev/null || true

echo "macOS defaults applied. Some changes may require a logout/restart."
