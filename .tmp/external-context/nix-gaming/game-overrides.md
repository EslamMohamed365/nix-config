---
source: GitHub README
library: nix-gaming
package: github:fufexan/nix-gaming
topic: game overrides and wine overriding
fetched: 2026-08-25
official_docs: https://github.com/fufexan/nix-gaming
---

# Game Overrides

Wine-based game derivations accept these arguments:

```nix
{
  wine      ? wine-ge,          # wine package used to run the game
  wineFlags ? "",               # flags to run wine with (literal string)
  pname     ? "game-name",      # name of the script and package
  location  ? "$HOME/${pname}", # where to install the game/wine prefix
  tricks    ? [],               # wine tricks to install

  preCommands  ? "",            # run commands before game starts
  postCommands ? "",            # run commands after game closes
}
```

## Override wine for specific games

```nix
{
  environment.systemPackages = let
    gamePkgs = inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system};
  in [
    gamePkgs.osu-stable.override rec {
      wine = <your-wine>;
      wine-discord-ipc-bridge = gamePkgs.wine-discord-ipc-bridge.override {inherit wine;};
    }
  ];
}
```

## Tips

- Use `linux_xanmod` kernel for best gaming performance (patches for wine, preemptive build, tickless scheduler)
- Use `gamemode` (Feral Interactive) for lower nice values + realtime privileges at game start
  - Detects games automatically or run with `gamemode-run`
