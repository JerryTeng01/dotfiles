#!/bin/bash

declare -A os;
os[/etc/debian_version]="apt-get install -y"
os[/etc/arch-release]="pacman -S"

for v in ${!os[@]}
do
    if [[ -f $v ]]; then
        package_manager=${os[$v]}
    fi
done

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

packages=(
    code
    gdb
    git 
    htop
    neofetch
    tmux
    wget
    vim
    zsh
)

${package_manager} ${packages[@]}

