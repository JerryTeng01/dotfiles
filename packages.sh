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

packages=(
    gdb
    git 
    htop
    neofetch
    python
    rofi
    tmux
    wget
    vim
    zsh
)

${package_manager} ${packages[@]}

