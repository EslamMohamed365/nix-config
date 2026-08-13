# Shared configuration for all hosts.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  time.timeZone = "Africa/Cairo";
  environment.systemPackages = with pkgs; [
    wget
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    FLAKE = "${config.users.users.eslam.home}/nix-config";
  };
  hardware = {
    enableAllFirmware = true;
  };
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };
  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };
    ssh = {
      startAgent = true;
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
  # Stylix theming
  stylix = {
    enable = true;
    image = ../walls/mountain-village.png;
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

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      substituters = [
        "https://cache.nixos.org"
      ];
    };
    channel.enable = false;
  };

  networking.networkmanager.enable = true;

  users.users = {
    eslam = {
      # Set with `passwd` after first boot
      initialHashedPassword = "$6$CQ.mis4Z5gINcCEQ$D5dang2V6CE3x4aL9z5NPrwPb7vUddFJPjQoYjW3KVbxnHLDO6btRgSNlaNIu18x9.lOXnIvEPQYS4Hri5E3k1";
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  services = {
    displayManager.ly.enable = true;
    auto-cpufreq.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.11";
}
