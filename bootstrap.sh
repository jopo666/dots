#!/bin/bash

set -euo pipefail

if [[ $# -gt 0 ]]; then
  echo "Usage: $0"; exit 1;
fi

echo ":: Creating directories..."
while IFS= read -r line; do
  if [[ -n "$line" && "$line" != \#* ]]; then
    mkdir -pv $(echo "$line" | awk '{print $1}' | sed "s|^~|$HOME|")
  fi
done < "directories.txt"

echo ":: Linking dotfiles..."
./bin/dot-link links.txt

echo ":: Installing dependencies"
nix profile install nixpkgs#jq

echo ":: Installing packages..."
./bin/dot-install -f packages.txt
