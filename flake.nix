{
  description = "eslam's NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NVF
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Firefox addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild switch --flake .#nix-btw'
    # or during install: 'nixos-install --flake .#nix-btw'
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        # > Our main nixos configuration file <
        modules = [
          stylix.nixosModules.stylix
          "${nixpkgs}/nixos/modules/hardware/facter"
          ./nixos/configuration.nix
          {hardware.facter.reportPath = ./facter.json;}
        ];
      };
    };
  };
}
