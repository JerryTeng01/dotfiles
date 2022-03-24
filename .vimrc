" install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.vim/plugged')

Plug 'wakatime/vim-wakatime'
Plug 'frazrepo/vim-rainbow'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fidian/hexmode'

call plug#end()

" vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" colors
set t_Co=256
set background=dark
colorscheme gruvbox

let g:rainbow_active = 1

" files to open in hex mode
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.pyc'

" options
set nu "rnu
set autoindent
set smartindent
set clipboard=unnamed
set ts=4 sw=4 sts=4 et
syntax on
set autoindent
set cursorline
set showmatch
set nobackup
set swapfile
set dir=/tmp
set noeol
set ignorecase
set smartcase
set visualbell
set t_vb=
filetype indent plugin on

set undofile " persistent undo between sessions
set undodir=~/.vim/undodir

" linters
let g:ale_linters = {'python': ['flake8', 'pylint']}

" python syntax
let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set foldmethod=indent
    \ set textwidth=79

" return to last edit place
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
