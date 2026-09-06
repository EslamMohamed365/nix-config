{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    shellAliases = {
      v = "nvim";
      c = "clear";
      vf = "nvim (fzf)";
      nos = "nh os switch";
      nclean = "nh clean all --optimise -k 3";
      oc = "opencode";
    };
    extraConfig = ''
      $env.config = {
        edit_mode: "vi"
      }
    '';
  };
}
