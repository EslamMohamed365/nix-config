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
  stylix = {
    targets.firefox.profileNames = [ "default" ];
  };
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  programs = {
    nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard.providers.wl-copy.enable = true;
    globals = {mapleader = " ";

    # # Disable useless providers
    loaded_ruby_provider = 0; # Ruby
    loaded_perl_provider = 0; # Perl
    loaded_python_provider = 0; # Python 2
    };
    opts = {
    number = true;         # Show line numbers
    relativenumber = true; # Show relative line numbers
    shiftwidth = 2;        # Tab width should be 2
    cursorline = true; 
	  };
    plugins = {lualine.enable = true;};
	};
    kitty = {
    enable = true;
    };
    firefox = {
    enable = true;
    };
    opencode = {
    enable = true;
    };
    lazygit = {
    enable = true;
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
  };
}
