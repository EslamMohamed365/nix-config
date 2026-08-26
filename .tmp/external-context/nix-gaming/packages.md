---
source: GitHub README + module source
library: nix-gaming
package: github:fufexan/nix-gaming
topic: packages list
fetched: 2026-08-25
official_docs: https://github.com/fufexan/nix-gaming
---

# nix-gaming Packages

## Game Packages

| Package | Description |
|---------|-------------|
| `faf-client` | Forged Alliance Forever client (multiple packages) |
| `osu-lazer-bin` | osu! lazer, extracted from the official AppImage |
| `osu-stable` | osu! stable version |
| `rocket-league` | Rocket League from Epic Games |
| `star-citizen` | Star Citizen |
| `technic-launcher` | Technic Launcher |

## Wine & Proton

| Package | Description |
|---------|-------------|
| `wine` | Multiple Wine packages (wine-ge, wine-tkg, etc.) |
| `wine-discord-ipc-bridge` | Wine-Discord RPC Bridge |
| `northstar-proton` | Proton build for Northstar client (Titanfall 2) |
| `winestreamproxy` | Wine-Discord RPC (broken) |

## Tools

| Package | Description |
|---------|-------------|
| `viper` | Launcher+Updater for Titanfall2 Northstar Client |
| `mo2installer` | Mod Organizer 2 installer script |

## legendaryBuilder

Function that installs games with `legendary-gl`. Requires `legendary auth` first.

```nix
# example.nix
{
  pkgs, inputs, ...
}: {
  environment.systemPackages = []
    ++ (inputs.nix-gaming.lib.legendaryBuilder pkgs {
      games = {
        rocket-league = {
          desktopName = "Rocket League";
          tricks = ["dxvk" "win10"];
          icon = pkgs.fetchurl {
            url = "https://user-images.githubusercontent.com/36706276/203341314-eaaa0659-9b79-4f40-8b4a-9bc1f2b17e45.png";
            name = "rocket-league.png";
            sha256 = "0a9ayr3vwsmljy7dpf8wgichsbj4i4wrmd8awv2hffab82fz4ykb";
          };
          discordIntegration = false;
          gamemodeIntegration = false;
          preCommands = ''echo "the game will start!"'';
          postCommands = ''echo "the game has stopped!"'';
        };
      };
      opts = {
        wine = inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.wine-tkg;
      };
    });
}
```

### legendaryBuilder options

```nix
{
  wine      ? wine-ge,          # wine package used to run games
  wineFlags ? "",               # flags to run wine with
  pname     ? "game-name",      # name of the script and package
  location  ? "$HOME/${pname}", # where to install the game/wine prefix
  tricks    ? [],               # wine tricks to install
  preCommands  ? "",            # run commands before game starts
  postCommands ? "",            # run commands after game closes
}
```
