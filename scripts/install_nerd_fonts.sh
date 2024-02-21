#!/usr/bin/env bash
set -ueo pipefail

echo ">> Downloading BlexMono Nerd Font"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/IBMPlexMono.zip
unzip IBMPlexMono.zip -d ~/.fonts
fc-cache -fv
rm IBMPlexMono.zip
