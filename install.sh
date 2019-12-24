#!/bin/bash
# installs contents of linuxprofile.git repository to current user's $HOME

HOMEFILES=(
".bashrc"
".aliases"
".gitconfig"
".inputrc"
".lftprc"
".tmux.conf"
".vimrc"
".pylintrc"
)

overwrite_homefiles(){
  for each_file in ${HOMEFILES[@]}; do
    echo "installing $each_file..."
    cp -rf $each_file ~/
  done
}

install_vim(){
  echo "installing .vim ftplugins, ftdetects, syntaxes and indents"
  rsync -a .vim/* ~/.vim/
}

install_binfiles(){
  rsync -av ./bin ~/
}

install_gitfiles(){
  rsync -av ./.git_hooks ~/
  # we don't want to overwrite an existing .gitcommittemplate
  if [[ ! -e ~/.gitcommittemplate ]]; then
    echo "Adding '.gitcommittemplate'..."
    cp .gitcommittemplate ~/
  fi
}

overwrite_homefiles
install_vim
install_binfiles
install_gitfiles

source ~/.bashrc


