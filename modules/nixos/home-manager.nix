{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.eslam = import ../home-manager/home.nix;
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "-bak";
  };
}
