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
      fetch
      git-extras
    ];
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "26.11";
  };
  stylix = {
    targets.firefox.profileNames = [ "eslam" ];
  };
  imports = [
    ./modules/firefox.nix
    ./modules/nvf.nix
  ];
  programs = {
  gh ={ 
  enable = true;
  };

    kitty = {
    enable = true;
    };
    opencode = {
    enable = true;
    };
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
}
