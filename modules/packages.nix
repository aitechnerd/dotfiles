{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── Fonts ──
    nerd-fonts.jetbrains-mono

    # ── Nix tools ──
    nixd
    nixfmt
  ];
}
