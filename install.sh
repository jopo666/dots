#!/bin/bash

set -euo pipefail

echo ":: Creating directories ::"
while IFS= read -r line; do
  if [[ -n "$line" && "$line" != \#* ]]; then
    mkdir -pv $(echo "$line" | awk '{print $1}' | sed "s|^~|$HOME|")
  fi
done < "directories.txt"

echo ":: Linking dotfiles ::"
while IFS= read -r line; do
  src=$(echo "$line" | awk '{print $1}' | sed "s|^~|$HOME|")
  dst=$(echo "$line" | awk '{print $3}' | sed "s|^~|$HOME|")
  if [ ! -e "$dst" ]; then
    ln -vs $src $dst
  fi
done < "links.txt"

read -n1 -p "Install packages? [y/n] " ANSWER
case $ANSWER in
  y|Y) echo ;;
  *) echo ""; exit 1 ;;
esac

echo ":: Installing packages [APT] ::"
sudo apt install $(cat packages/apt.txt | sed 's/#.*//' | tr "\n" " ") -y

echo ":: Installing packages [SNAP] ::"
while ifs= read -r package; do
  if [[ -n "$package" && "$package" != \#* ]]; then
    sudo snap install $package --classic
  fi
done < "./packages/snap.txt"

echo ":: Installing packages [BREW] ::"
while ifs= read -r package; do
  if [[ -n "$package" && "$package" != \#* ]]; then
    brew install $package
  fi
done < "./packages/brew.txt"
