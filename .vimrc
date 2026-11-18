set nocompatible
syntax on
filetype plugin indent on

set number
set norelativenumber

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

set mouse=a

set cursorline
set cursorlineopt=both

augroup MyCursorLine
  autocmd!
  autocmd ColorScheme * highlight CursorLine   cterm=NONE ctermbg=235
  autocmd ColorScheme * highlight CursorLineNr cterm=NONE ctermbg=235
augroup END

highlight CursorLine   cterm=NONE ctermbg=235
highlight CursorLineNr cterm=NONE ctermbg=235

set hidden
set incsearch hlsearch
set ignorecase smartcase
set scrolloff=5
set wildmenu
set clipboard=unnamedplus
set noswapfile
set undofile undodir=~/.vim/undo
