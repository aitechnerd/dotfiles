{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons --git";
      cat = "bat";
      grep = "rg";
      find = "fd";
      cd = "z";

      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";

      rebuild = "darwin-rebuild switch --flake ~/Projects/dotfiles";
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
      source <(fzf --zsh)
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
