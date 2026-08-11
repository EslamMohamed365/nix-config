#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DISK="${1:-/dev/nvme0n1}"

if [[ ! -e "${TARGET_DISK}" ]]; then
  echo "Error: target disk '${TARGET_DISK}' not found."
  exit 1
fi

if [[ -d "${SCRIPT_DIR}/.git" ]] && ! git -C "${SCRIPT_DIR}" diff --quiet; then
  echo "Warning: uncommitted changes in '${SCRIPT_DIR}' will NOT be part of the installed system."
  echo "Commit your changes first if the configuration must match this checkout."
fi

echo "Target disk: ${TARGET_DISK}"
read -r -p "WARNING: '${TARGET_DISK}' will be wiped. Type 'yes' to continue: " CONFIRM
if [[ "${CONFIRM}" != "yes" ]]; then
  echo "Aborted."
  exit 1
fi

sudo nix run --extra-experimental-features "nix-command flakes" \
  'github:nix-community/disko/latest#disko-install' \
  -- --flake "${SCRIPT_DIR}#nix-btw" \
  --disk main "${TARGET_DISK}" \
  --write-efi-boot-entries \
  --option accept-flake-config true

echo ""
echo "Installation complete."
echo "Remove the installer media and reboot."
