# Gaming: NVIDIA proprietary driver, Vulkan, Steam, GameMode, nix-gaming
{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  # NVIDIA proprietary driver (nouveau can't game)
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Vulkan + OpenGL (both 32-bit for Steam/Proton)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Steam with platform optimizations from nix-gaming
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      platformOptimizations.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
    gamemode.enable = true;
  };

  environment.systemPackages = [
    pkgs.wineWow64Packages.staging
    pkgs.winetricks
  ];

  # Launch games with nvidia-offload env by default
  environment.sessionVariables = {
    "WINE_FULLSCREEN_FSR" = "1";
  };
}
