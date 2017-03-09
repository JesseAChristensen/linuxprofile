set nocompatible
" filetype off

" if ~/.vim/bundle exists, lets activate it!
if !empty(glob("~/.vim/bundle"))
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  " Note: please run 'vim +BundleInstall' on the command line to install
  " these plugins.
  Plugin 'bundle/Vundle.vim'
  " Plugins go below here
  Bundle 'Valloric/YouCompleteMe'
  Bundle 'chase/vim-ansible-yaml'
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
