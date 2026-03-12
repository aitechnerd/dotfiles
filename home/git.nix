{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Sergey Belov";
    userEmail = "belov.ss@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      diff.algorithm = "histogram";
      merge.conflictstyle = "diff3";
      rerere.enabled = true;
      credential.helper = "osxkeychain";
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };

    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv/"
      "result"
    ];
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
