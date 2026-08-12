{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

  };
}
