{...}: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      v = "nvim";
      vf = "nvim $(fzf)";
      nos = "nh os switch";
      nclean = "nh clean all --optimise -k 3";
      pq = "~/quran/play_quran_random.sh";
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
        "extract"
        "eza"
        "kitty"
        "tmux"
      ];
    };
  };
}
