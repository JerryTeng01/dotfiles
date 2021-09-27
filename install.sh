#!/bin/bash

# additional tools for binaries
#pip3 install capstone unicorn keystone-engine ropper

# gef
#if [ ! -f !/.gdbinit-gef.py ]; then
#    wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
#fi

if [ ! -d ~/.oh-my-zsh ]; then
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

files=(
    ".aliases" 
    ".functions" 
    ".gitconfig" 
    ".p10k.zsh"
    ".vimrc" 
    ".zshenv" 
    ".zshrc"
)

for file in ${files[@]}; do
    ln -sf $(pwd)/$file $HOME
done

[ ! -d $HOME/.vim/undodir ] && mkdir $HOME/.vim/undodir

#[ ! -d $HOME/.config ] && mkdir $HOME/.config
#[ ! -d $HOME/.config/VSCodium/User ] && mkdir -p $HOME/.config/VSCodium/User

#ln -sf $(pwd)/config/VSCodium/product.json $HOME/.config/VSCodium/product.json
#ln -sf $(pwd)/config/VSCodium/User/settings.json $HOME/.config/VSCodium/User/settings.json

#[ -d $HOME/.config/alacritty ] && rm -fr $HOME/.config/alacritty
#ln -sf $(pwd)/config/alacritty $HOME/.config/alacritty

#[ -d $HOME/.config/nitrogen ] && rm -fr $HOME/.config/nitrogen
#ln -sf $(pwd)/config/nitrogen $HOME/.config/nitrogen

#[ -d $HOME/.config/picom ] && rm -fr $HOME/.config/picom
#ln -sf $(pwd)/config/picom $HOME/.config/picom

#[ -d $HOME/.config/qtile ] && rm -fr $HOME/.config/qtile
#ln -sf $(pwd)/config/qtile $HOME/.config/qtile

#[ -d $HOME/.config/qtile ] && rm -fr $HOME/.config/qtile
#ln -sf $(pwd)/config/qtile $HOME/.config/qtile
