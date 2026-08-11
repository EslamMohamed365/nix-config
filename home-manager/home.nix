# This is your home-manager configuration file
# Used via the NixOS-integrated module (home-manager.users.eslam)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home = {
    username = "eslam";
    homeDirectory = "/home/eslam";
    packages = with pkgs; [
      ripgrep
    ];
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "26.11";
  };

  programs = {
    neovim.enable = true;
    git.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/eslam/nix-config/"; # sets NH_OS_FLAKE variable for you
    };
  };
}
