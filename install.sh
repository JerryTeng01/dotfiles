#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -f $HOME/.fonts/SourceCodePro-Medium.otf ]; then
    mkdir /tmp/adodefont
    cd /tmp/adodefont
    wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip
    unzip 1.017R.zip
    mkdir -p ~/.fonts
    cp source-code-pro-1.017R/OTF/*.otf ~/.fonts/
    fc-cache -f -v
    cd -
fi

wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py

files=(
    ".aliases" 
    ".functions" 
    ".gitconfig"
    ".gdbinit"
    ".rclone-filter"
    ".tmux.conf"
    ".vimrc" 
    ".xinitrc"
    ".xprofile"
    ".zshenv" 
    ".zshrc"
)

for file in ${files[@]}; do ln -sfv $HOME/dotfiles/$file $HOME
done

if [ ! -d $HOME/.vim/undodir ]; then
    mkdir -p $HOME/.vim/undodir
fi

[ -d $HOME/.config/alacritty ] && rm -fr $HOME/.config/alacritty
ln -sf $(pwd)/config/alacritty $HOME/.config/alacritty

[ -d $HOME/.config/nitrogen ] && rm -fr $HOME/.config/nitrogen
ln -sf $(pwd)/config/nitrogen $HOME/.config/nitrogen

[ -d $HOME/.config/picom ] && rm -fr $HOME/.config/picom
ln -sf $(pwd)/config/picom $HOME/.config/picom

[ -d $HOME/.config/qtile ] && rm -fr $HOME/.config/qtile
ln -sf $(pwd)/config/qtile $HOME/.config/qtile

