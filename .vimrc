set nocompatible
" filetype off

" if ~/.vim/bundle exists, lets activate it!
" if it doesn't exist, git it from 
" $ git clone https://github.com/VundleVim/Vundle.vim.git
" ~/.vim/bundle/Vundle.vim
"
if !empty(glob("~/.vim/bundle"))
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  " Note: please run 'vim +BundleInstall' on the command line to install
  " these plugins.
  " Note: also run from inside vim: ":helptags ~/.vim/doc"
  " # vim:ft=ansible sets the vim filetype to ansible
  Plugin 'bundle/Vundle.vim'
  " Plugins go below here
  Bundle 'Valloric/YouCompleteMe'
  Plugin 'scrooloose/syntastic'
  " Plugins go above here
  call vundle#end()
endif

filetype plugin on
filetype plugin indent on


nnoremap <space> za
inoremap jk <Esc>
nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

" colorscheme murphy
syntax on
let python_highlight_all=1
set nu

function! s:doPyVEnv()
  py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
  return 1
endfunction

"python with virtualenv support
if has('python')
  call s:doPyVEnv()
endif

if &diff
  colorscheme murphy
endif
