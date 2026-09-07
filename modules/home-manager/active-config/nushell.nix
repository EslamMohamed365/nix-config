{inputs, ...}: {
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
              buffer_editor : "nvim"
            }
            $env.EDITOR = "nvim"
            $env.VISUAL = "nvim"
      use ${inputs.nu-scripts}/custom-completions/aws/aws-completions.nu *
      use ${inputs.nu-scripts}/custom-completions/gh/gh-completions.nu *
    '';
  };
}
