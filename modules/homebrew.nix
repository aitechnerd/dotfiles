{ ... }:

{
  # ══════════════════════════════════════════════
  #  Homebrew — GUI apps via casks
  #  nix-darwin manages Homebrew declaratively
  # ══════════════════════════════════════════════

  homebrew = {
    enable = true;

    # No analytics
    global.autoUpdate = false;

    onActivation = {
      autoUpdate = true;     # update homebrew on rebuild
      upgrade = true;        # upgrade outdated casks
      cleanup = "zap";       # remove casks not listed here
    };

    # ── CLI tools not in nixpkgs (or better via brew) ──
    brews = [
      # Add brew formulas here if needed
    ];

    # ── GUI Applications ──
    casks = [
      # AI
      "claude"
      "claude-code"
      "codex"

      # Terminal
      "ghostty"

      # Editor
      "zed"

      # Cloud sync
      "nextcloud"

      # Password manager (Safari extension — only for passkeys)
      "bitwarden"

      # Database
      "dbeaver-community"

      # Utilities
      "hammerspoon"          # automation (until tileport replaces it)
      "localsend"            # local network file sharing
    ];
  };
}
