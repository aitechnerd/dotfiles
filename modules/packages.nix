{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── Fonts ──
    nerd-fonts.jetbrains-mono

    # ── Nix tools ──
    nil
    nixfmt
  ];
}
