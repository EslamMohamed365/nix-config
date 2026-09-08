{
  programs.nushell = {
    enable = true;
    shellAliases = {
      v = "nvim";
      c = "clear";
      vf = "nvim (fzf --preview 'head -n 100 {}' -m | str trim)";
      nos = "nh os switch";
      nclean = "nh clean all --optimise -k 3";
      oc = "opencode";
      ll = "ls -la";
    };
    extraConfig = ''
      $env.config = {
        edit_mode: "vi"
        buffer_editor : "nvim"
      }
      $env.EDITOR = "nvim"
      $env.VISUAL = "nvim"
    '';
  };
}
