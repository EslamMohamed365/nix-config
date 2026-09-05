# Gaming: NVIDIA proprietary driver, Vulkan, Steam, GameMode, nix-gaming
{
  config,
  pkgs,
  ...
}: {
  # NVIDIA proprietary driver (nouveau can't game)
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
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

  programs = {
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          softrealtime = "auto";
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          nv_powermizer_mode = 1;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'gamemode' 'optimizations active'";
          end = "${pkgs.libnotify}/bin/notify-send 'gamemode' 'optimizations deactivated'";
        };
      };
    };
  };

  # Launch games with nvidia-offload env by default
  environment.sessionVariables = {
    "WINE_FULLSCREEN_FSR" = "1";
    "DXVK_ASYNC" = "1";
    "__GL_SHADER_DISK_CACHE_SKIP_CLEANUP" = "1";
  };
}
