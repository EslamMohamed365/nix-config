# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Declarative disk partitioning (defines fileSystems, replaces
    # hardware-configuration.nix for mounting)
    inputs.disko.nixosModules.disko
    ../disko-config.nix
    ./hardware-configuration.nix
    # NixOS-integrated Home Manager (useGlobalPkgs = true)
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.eslam = import ../home-manager/home.nix;
        extraSpecialArgs = {inherit inputs;};
      };
    }
  ];

  # Bootloader (UEFI)
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
hardware = {
enableRedistributableFirmware = true;
enableAllFirmware = true;

};
programs = {
hyprland.enable = true;
};
  nixpkgs = {
    # You can add overlays here
    overlays = [];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
    };
    # Opinionated: disable channels
    channel.enable = false;
  };

  networking.hostName = "nix-btw";
  networking.networkmanager.enable = true;

  users.users = {
    eslam = {
      # TODO: Change this password after first boot (passwd)
      initialPassword = "mypasswd";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["wheel" "networkmanager"];
    };
  };

  # SSH server. Useful for headless installs.
  services = { openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Passwords enabled so you can log in until you add your SSH keys.
      # Switch to false once authorizedKeys.keys is populated.
      PasswordAuthentication = true;
    };
  };
  displayManager.ly = {
  enable = true;
  };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.11";
}
