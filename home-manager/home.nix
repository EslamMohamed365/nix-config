# This is your home-manager configuration file
# Used via the NixOS-integrated module (home-manager.users.eslam)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{

  home = {
    username = "eslam";
    homeDirectory = "/home/eslam";
    packages = with pkgs; [
      ripgrep
      fetch
      git-extras
      fd
      wl-clipboard-rs
    ];
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "26.11";
  };
  stylix = {
    targets.firefox.profileNames = [ "eslam" ];
  };
  imports = [
    ./modules/firefox.nix
    ./modules/hyprland.nix
    ./modules/nvf.nix
  ];
  programs = {
    fzf = {
      enable = true;
    };

    fuzzel = {
      enable = true;
    };
    gh = {
      enable = true;
    };
    hyprshot = {
      enable = true;
      saveLocation = "$HOME/Pictures/Screenshots";
    };
    waybar = {
      enable = true;
      systemd.enable = true;
    };
    yazi = {
      enable = true;
    };
    ssh = {
      enable = true;
    };

    kitty = {
      enable = true;
    };
    mpv = {
      enable = true;
    };
    opencode.enable = true;
    lazygit = {
      enable = true;
      shellWrapperName = "lg";
    };
    git = {
      enable = true;
      settings = {
        user.name = "EslamMohamed365";
        user.email = "am5484452@gmail.com";
        init.defaultBranch = "main";
      };
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/eslam/nix-config/"; # sets NH_OS_FLAKE variable for you
    };
    tealdeer.enable = true;
  };
  services = {
    mako.enable = true;
  };
}
