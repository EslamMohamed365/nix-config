# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Shared configuration across hosts
    ./base.nix
    # Declarative disk partitioning (defines fileSystems, replaces
    # hardware-configuration.nix for mounting)
    inputs.disko.nixosModules.disko
    ../disko-config.nix
    # NixOS-integrated Home Manager (useGlobalPkgs = true)
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.eslam = import ../home-manager/home.nix;
        extraSpecialArgs = { inherit inputs; };
        backupFileExtension = "-bak";
      };
    }
  ];
  # Bootloader (UEFI)
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nix-btw";
}