{ pkgs, username, hostname, ... }:

{
  # ── Machine identity ──
  networking.hostName = hostname;
  networking.computerName = hostname;

  # ── User ──
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  # ── Nix settings ──
  # Determinate Nix manages the daemon, so disable nix-darwin's management
  nix.enable = false;

  # ── Primary user (required for user-specific system options) ──
  system.primaryUser = username;

  # ── Enable zsh (default shell on macOS) ──
  programs.zsh.enable = true;

  # ── Platform ──
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compat — don't change
  system.stateVersion = 6;
}
