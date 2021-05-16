if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'wakatime/vim-wakatime'
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'
"Plug 'vimsence/vimsence'

call plug#end()

set termguicolors

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:airline_theme = "tokyonight"

colorscheme tokyonight

set nu rnu
set clipboard=unnamed
set ts=4 sw=4 sts=4 et
syntax enable
set autoindent
set cursorline
set showmatch
set nobackup
set swapfile
set dir=/tmp
set noeol
"set visualbell
"set t_vb=

