{ pkgs, ... }:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
    };
  };

  programs.git = {
    enable = true;

    settings = {
      user.name = "Sergey Belov";
      user.email = "belov.ss@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      diff.algorithm = "histogram";
      merge.conflictstyle = "diff3";
      rerere.enabled = true;
      credential.helper = "osxkeychain";
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
