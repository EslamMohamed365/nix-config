#!/usr/bin/env bash
sudo nix run --extra-experimental-features "nix-command flakes" \
  'github:nix-community/disko/latest#disko-install' \
  -- --flake github:EslamMohamed365/nix-config#nix-btw \
  --disk main /dev/nvme0n1 \
  --write-efi-boot-entries \
  --accept-flake-config
