{pkgs, ...}: {
  programs.lutris = {
    enable = true;

    protonPackages = [
      pkgs.proton-ge-bin
    ];

    winePackages = [
      pkgs.wineWow64Packages.staging
    ];

    extraPackages = with pkgs; [
      gamemode
      winetricks
    ];
  };

  home.packages = with pkgs; [
    wineWow64Packages.staging
    winetricks
  ];
}
