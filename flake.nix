{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    stylix,
    wrappers,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [wrappers.flakeModules.wrappers];

      perSystem = {pkgs, ...}: {
        packages.neovim = pkgs.callPackage ./modules/wrappers/nvim.nix {};
        packages.nvf = let
          hmModule = import ./modules/home-manager/active-config/nvf.nix {inherit inputs;};
        in
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [
              {config.vim = hmModule.programs.nvf.settings.vim;}
            ];
          }).neovim;
      };

      flake.wrappers.tmux = import ./modules/wrappers/tmux.nix;

      flake.nixosConfigurations = {
        nix-btw = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            stylix.nixosModules.stylix
            "${nixpkgs}/nixos/modules/hardware/facter"
            {hardware.facter.reportPath = ./facter.json;}
            (inputs.import-tree ./modules/nixos)
          ];
        };
      };
    };
}
