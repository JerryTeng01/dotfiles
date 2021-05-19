if [ ! -d ~/.oh-my-zsh ]; then
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

files=(".aliases" ".functions" ".gdbinit" ".gitconfig" ".git_aliases" ".profile" ".vimrc" ".zshrc")

for file in ${files[@]}; do
    ln -sf $(pwd)/$file $HOME
done

[ ! -d $HOME/.config ] && mkdir $HOME/.config

[ -d $HOME/.config/alacritty ] && rm -fr $HOME/.config/alacritty
ln -sf $(pwd)/config/alacritty $HOME/.config/alacritty

[ -d $HOME/.config/nitrogen ] && rm -fr $HOME/.config/nitrogen
ln -sf $(pwd)/config/nitrogen $HOME/.config/nitrogen

[ -d $HOME/.config/picom ] && rm -fr $HOME/.config/picom
ln -sf $(pwd)/config/picom $HOME/.config/picom

[ -d $HOME/.config/qtile ] && rm -fr $HOME/.config/qtile
ln -sf $(pwd)/config/qtile $HOME/.config/qtile

