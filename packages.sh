#!/bin/bash

declare -A os;
os[/etc/debian_version]="apt install -y"
os[/etc/arch-release]="pacman -S"

for v in ${!os[@]}
do
    if [[ -f $v ]]; then
        package_manager=${os[$v]}
    fi
done

packages=(
    curl
    htop
    neofetch
    python-is-python3
    python3-venv
    python3-pip
    solaar
    tlp
    tlp-rdw
    tmux
    wget
    vim
    zsh
)

npm_packages=(
    @bitwarden/cli
)

${package_manager} ${packages[@]}

which node > /dev/null 2>&1
if [ $? != 0  ]; then
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

which spotify > /dev/null 2>&1
if [ $? != 0  ]; then
    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y spotify-client
fi

npm install -g ${npm_packages[@]}

sudo tlp start

