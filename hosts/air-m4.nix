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
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # Avoid warning about trusted users
    trusted-users = [ "root" username ];
  };

  # ── Enable nix-daemon ──
  services.nix-daemon.enable = true;

  # ── Enable zsh (default shell on macOS) ──
  programs.zsh.enable = true;

  # ── Platform ──
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compat — don't change
  system.stateVersion = 6;
}
