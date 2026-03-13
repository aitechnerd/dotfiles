{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── Core utils ──
    fd
    ripgrep
    jq
    bat
    eza
    zoxide
    fzf
    curl

    # ── Development ──
    git
    gh
    delta

    # ── Fonts ──
    nerd-fonts.jetbrains-mono

    # ── Nix tools ──
    nil
    nixfmt
  ];
}
