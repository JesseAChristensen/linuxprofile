#!/bin/bash
HOMEFILES=(
".bashrc"
".gitconfig"
".inputrc"
".lftprc"
".tmux.conf"
".vimrc"
)
echo -e "This will install the following files into $HOME, overwriting existing files:"
for each_file in ${HOMEFILES[@]}; do
  echo $each_file
done
echo -e "Are you sure you want to proceed? [N/y]"
read PROCEED
if ! $(echo $PROCEED | grep -qP "[Yy][Ee[Ss]?]?"); then
  echo -e "Aborting..."
  exit 0
fi
for each_file in ${HOMEFILES[@]}; do
  cp -i $each_file ~/
done

source ~/.bashrc
