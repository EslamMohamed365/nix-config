{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman # optional, add if needed
    ];
  };
}
