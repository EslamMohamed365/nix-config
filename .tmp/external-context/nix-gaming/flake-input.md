---
source: GitHub README
library: nix-gaming
package: github:fufexan/nix-gaming
topic: flake input setup
fetched: 2026-08-25
official_docs: https://github.com/fufexan/nix-gaming
---

# Adding nix-gaming as a Flake Input

## flake.nix

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {self, nixpkgs, ...}@inputs: {
    nixosConfigurations.HOSTNAME = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
      ];
    };
  };
}
```

## Cachix (recommended - avoid building wine etc.)

```nix
# configuration.nix
{
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };
}
```

## Install packages (NixOS or Home Manager)

```nix
{pkgs, inputs, ...}: {
  environment.systemPackages = [   # or home.packages
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.<package>
  ];
}
```

## Or via profile

```bash
nix profile install github:fufexan/nix-gaming#<package>
```

## Overlay alternative

```nix
# Everything is available as an overlay, though results may differ from packages
nixpkgs.overlays = [ inputs.nix-gaming.overlay ];
```

## Non-flakes (Nix stable)

```nix
{pkgs, ...}: let
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {
  environment.systemPackages = [
    nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.<package>
  ];
}
```
