#!/bin/bash
HOMEFILES=(
.bashrc
.gitconfig
.inputrc
.lftprc
.tmux.conf
.vimrc
)
for each_file in $HOMEFILES; do
  cp -i $each_file ~/
done

source ~/.bashrc
