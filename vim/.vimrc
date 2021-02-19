if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'wakatime/vim-wakatime'
Plug 'franbach/miramare'
Plug 'sheerun/vim-polyglot'
Plug 'hugolgst/vimsence'

call plug#end()

set termguicolors

" the configuration options should be placed before `colorscheme miramare`
let g:miramare_enable_italic = 1
let g:miramare_disable_italic_comment = 1
let g:airline_theme = 'miramare'

colorscheme miramare

set number
syntax enable
set tabstop=4
set autoindent
set expandtab
set softtabstop=4
set cursorline
set showmatch
set nobackup
set swapfile
set dir=/tmp
