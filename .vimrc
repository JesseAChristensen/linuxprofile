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
  Bundle 'rdnetto/YCM-Generator'
  " Plugins go above here
  call vundle#end()
  let g:ycm_confirm_extra_conf = 0
endif

" if ~/.vimundo exists and vim has been compiled with persistent_undo, enable
" the persistent_undo capability and set the undo directory.
let vimDir = "~/.vim"
let &runtimepath.=','.vimDir
if has('persistent_undo')
"  let myUndoDir = expand(vimDir . '/undodir')
  call system('mkdir -p ~/.vim/undodir')
  set undodir=~/.vim/undodir
  set undofile
endif

if &diff
  colorscheme murphy
else
  filetype plugin on
  filetype plugin indent on
endif

nnoremap <space> za
inoremap jk <Esc>
nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

nnoremap <silent> <C-w>L :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <C-w>H :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <C-w>K :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <C-w>J :exe "resize " . (winheight(0) * 2/3)<CR>

set nu

syntax on
let python_highlight_all=1

let USERENV=$USERNAME
if USERENV != 'root'
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
endif

