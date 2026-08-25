{pkgs, ...}: {
  stylix = {
    enable = true;
    icons = {
      package = pkgs.gruvbox-plus-icons;
      enable = true;
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
    };
    image = ../../walls/mountain-village.png;
    opacity = {
      applications = 0.85;
      terminal = 0.75;
      desktop = 0.80;
      popups = 0.80;
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
