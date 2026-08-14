{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "starship"
        "git-extras"
        "copybuffer"
        "copyfile"
        "copypath"
        "cp"
        "extract"
        "eza"
        "kitty"
      ];
    };

  };
}
