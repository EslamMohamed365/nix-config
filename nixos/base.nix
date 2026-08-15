# Shared configuration for all hosts.
{
  config,
  lib,
  pkgs,
  ...
}: {
  time.timeZone = "Africa/Cairo";
  environment.systemPackages = with pkgs; [
    ntfs3g
    wget
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    FLAKE = "${config.users.users.eslam.home}/nix-config";
  };
  # hardware = {
  #   enableAllFirmware = true;
  # };
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
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
  };
  stylix = {
    enable = true;
    icons = {
      package = pkgs.gruvbox-plus-icons;
      enable = true;
      # stylix >= 2511 no longer derives the theme name from the package
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
    };
    image = ../walls/mountain-village.png;
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

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "";
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nvf.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
      ];
    };
    channel.enable = false;
  };

  networking.networkmanager.enable = true;

  users.users = {
    eslam = {
      #TODO: Set with `passwd` after first boot
      initialPassword = "mypasswd";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  security.rtkit.enable = true;
  services = {
    displayManager.ly.enable = true;
    auto-cpufreq.enable = true;
    pipewire = {
      enable = true; # if not already enabled
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment the following
      #jack.enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";
}
