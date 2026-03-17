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

for pkg in "${packages[@]}"; do
    if brew list --formula "$pkg" &>/dev/null; then
        echo "✓ $pkg"
    else
        echo "Installing $pkg..."
        brew install "$pkg"
    fi
done

if ! command -v node &>/dev/null; then
    brew install node@22
    brew link --overwrite node@22
fi

if [ ! -d "/Applications/Spotify.app" ]; then
    brew install --cask spotify
fi
