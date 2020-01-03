#!/bin/bash
# installs contents of linuxprofile.git repository to current user's $HOME

HOMEFILES=(
"bashrc"
"aliases"
"inputrc"
"lftprc"
"tmux.conf"
"vimrc"
"pylintrc"
)

overwrite_homefiles(){
  for each_file in ${HOMEFILES[@]}; do
    echo "installing $each_file to ~/.$each_file"
    cp -rf $each_file ~/.$each_file
  done
}

install_vim(){
  echo "installing .vim ftplugins, ftdetects, syntaxes and indents"
  mkdir -p ~/.vim
  rsync -av vim/* ~/.vim/
}

install_binfiles(){
  rsync -av ./bin ~/
}

install_gitfiles(){
  mkdir -p ~/.git_hooks
  rsync -av ./git_hooks/* ~/.git_hooks/
  cp ./gitconfig ~/.gitconfig
  if [[ ! -e ~/.gitcommittemplate ]]; then
    echo "Adding '.gitcommittemplate'..."
    cp ./gitcommittemplate ~/.gitcommittemplate
  fi
  if [[ ! -e ~/.gitCommitTemplatePost ]]; then
    cp ./gitCommitTemplatePost ~/.gitCommitTemplatePost
  fi
}

install_sshfiles(){
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  if [[ ! -e ~/.ssh/config ]]; then
    cp ssh/config ~/.ssh/
  fi
}

overwrite_homefiles
install_vim
install_binfiles
install_gitfiles
install_sshfiles

source ~/.bashrc

