#!/bin/bash

if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

packages=(
    curl
    fastfetch
    htop
    python3
    tmux
    wget
    vim
    zsh
)

brew install ${packages[@]}

if ! command -v node &>/dev/null; then
    brew install node@22
    brew link node@22
fi

if ! brew list --cask spotify &>/dev/null; then
    brew install --cask spotify
fi
