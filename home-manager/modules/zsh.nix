{pkgs, ...}: {
  programs.zsh = {
    initExtra = ''
      eval "$(${pkgs.devenv}/bin/devenv hook zsh)"
    '';
    enable = true;
    shellAliases = {
      v = "nvim";
      vf = "nvim $(fzf)";
      nos = "nh os switch";
      nclean = "nh clean all --optimise -k 3";
    };
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
        "eza"
        "kitty"
        "tmux"
      ];
    };
  };
}
