{ config, pkgs, username, dotfilesPath, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  # ── Zed editor config (mutable — edit in repo, commit to git) ──
  home.file.".config/zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/zed/settings.json";

  # ── Tileport window manager config ──
  home.file.".config/tileport/tileport.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/tileport/tileport.toml";

  # ── Nextcloud symlinks ──
  # Replace macOS directories with Nextcloud-synced versions
  # First time: move existing ~/Documents contents into ~/Nextcloud/Documents
  home.file."Documents".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/${username}/Nextcloud/Documents";

  # ── Session variables ──
  home.sessionVariables = {
    EDITOR = "zed --wait";
    VISUAL = "zed --wait";
    LANG = "en_US.UTF-8";
    HOMEBREW_NO_ANALYTICS = "1";
  };
}
