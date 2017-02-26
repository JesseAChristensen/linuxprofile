set nocompatible
" filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'bundle/Vundle.vim'

" Plugins go below here
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
" Plugins go above here
call vundle#end()
filetype plugin on
filetype plugin indent on


nnoremap <space> za
inoremap jk <Esc>
nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

colorscheme murphy
set foldmethod=indent
set foldlevel=0
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set fileformat=unix
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=79
    \set expandtab
    \set autoindent
    \set fileformat=unix
    \nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>
let python_highlight_all=1
syntax on
set nu


"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
