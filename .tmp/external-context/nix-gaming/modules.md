---
source: GitHub README + module source
library: nix-gaming
package: github:fufexan/nix-gaming
topic: nixos modules
fetched: 2026-08-25
official_docs: https://github.com/fufexan/nix-gaming
---

# nix-gaming NixOS Modules

Available modules:
- `pipewireLowLatency` - PipeWire low latency audio
- `platformOptimizations` - SteamOS sysctl tweaks
- `wine` - Wine system integration with binfmt + ntsync

## Importing modules

```nix
# Flakes
{inputs, ...}: {
  imports = [
    inputs.nix-gaming.nixosModules.<module name>
  ];
}

# Non-flakes
{pkgs, ...}: let
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {
  imports = [
    nix-gaming.nixosModules.<module name>
  ];
}
```

---

## PipeWire Low Latency (`pipewireLowLatency`)

Extends nixpkgs PipeWire module. Enables low latency audio in a few lines.

```nix
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      enable = true;       # enable this module
      quantum = 64;        # default
      rate = 48000;        # default
    };
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;
}
```

- If no sound, increase `quantum`
- Latency formula: `quantum / rate` (e.g. 48/48000 = 1ms)

---

## Platform Optimizations (`platformOptimizations`)

Applies SteamOS sysctl settings for gaming performance.

```nix
{
  programs.steam.platformOptimizations.enable = true;
}
```

### What it sets:

| sysctl | Value | Purpose |
|--------|-------|---------|
| `kernel.sched_cfs_bandwidth_slice_us` | 3000 | Scheduler tuning |
| `net.ipv4.tcp_fin_timeout` | 5 | Faster TCP port reuse for game restarts |
| `kernel.split_lock_mitigate` | 0 | Prevents intentional game slowdowns (kernel 6.0+) |
| `vm.max_map_count` | 2147483642 | MAX_INT mapcount for games |

---

## Wine Module (`wine`)

System-level Wine integration with binfmt and ntsync support.

```nix
{
  programs.wine = {
    enable = true;
    package = pkgs.wine-wow64;  # or your preferred wine
    binfmt = true;              # register as interpreter for .exe
    ntsync = true;              # requires Linux 6.14+
  };
}
```

### Options:
- `enable` - Install wine and set `WINE_BIN` env var
- `package` - Which wine package to use
- `binfmt` - Register DOSWin binfmt (run .exe directly)
- `ntsync` - Enable ntsync kernel module + udev rules (Linux 6.14+ only)

---

## steamCompat (DEPRECATED)

Use `programs.steam.extraCompatPackages` from nixpkgs instead:
https://github.com/NixOS/nixpkgs/pull/293564
