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

    taps = [
      "aitechnerd/sshore"
    ];

    # ── CLI tools not in nixpkgs (or better via brew) ──
    brews = [
      # Core utils
      "fd"
      "ripgrep"
      "jq"
      "bat"
      "eza"
      "zoxide"
      "fzf"

      # Development
      "git"
      "gh"
      "delta"
      "rust"
      "tmux"

      # SSH manager
      "sshore"

      # File manager
      "midnight-commander"
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
      "hiddenbar"            # hide menu bar icons

      # Quick Look plugins
      "qlmarkdown"
      "qlstephen"            # preview plain text files without extension
      "qlcolorcode"          # syntax highlighting in Quick Look
    ];
  };
}
