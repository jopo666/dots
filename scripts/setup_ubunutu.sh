#!/usr/bin/env bash
set -euo pipefail

if [[ ! -e scripts ]]; then
    echo "ERROR: Are you in project root?"
    exit 1
fi


echo ">> Install dependencies? (y/n)"
read -r install_deps
if [[ "$install_deps" == "y" ]]; then
    sudo apt update -q && sudo apt upgrade -q
    sudo apt install -yq \
        brightnessctl \
        build-essential \
        curl \
        dunst \
        feh \
        git \
        i3 \
        i3lock \
        i3status \
        network-manager \
        picom \
        pulseaudio \
        libnotify-bin \
        pulsemixer \
        scrot \
        tar \
        unclutter-xfixes \
        x11-xserver-utils \
        xclip \
        xinit

    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed, please restart your terminal"
    fi
fi


echo ">> Make directories and link dotfiles? (y/n)"
read -r make_dirs
if [[ "$make_dirs" == "y" ]]; then
    bash ./scripts/make_directories.sh
    bash ./scripts/link_dotfiles.sh
fi

echo ">> Install tools? (y/n)"
read -r install_tools
if [[ "$install_tools" == "y" ]]; then
    brew install \
        bat \
        delta \
        fzf \
        go \
        htop \
        lazygit \
        neovim \
        nnn \
        node \
        npm \
        pipx \
        python@3.10 \
        python@3.11 \
        ripgrep \
        slides \
        tmux \
        tree \
        zig
fi

echo ">> Install applications? (y/n)"
read -r install_snap
if [[ "$install_snap" == "y" ]]; then
    sudo snap install --classic alacritty
    sudo snap install --classic firefox
fi

echo ">> Add user to groups? (y/n)"
read -r add_user_to_groups
if [[ "$add_user_to_groups" == "y" ]]; then
    sudo usermod -a -G video "${USER}"
fi
