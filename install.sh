#!/bin/bash
helpmsg(){
  echo -e "usage:" 
  echo -e "-f : force install without user interaction"
}

HOMEFILES=(
".bashrc"
".gitconfig"
".inputrc"
".lftprc"
".tmux.conf"
".vimrc"
)

if [[ "$1" == "-f" ]]; then
  for each_file in ${HOMEFILES[@]}; do
    cp -f $each_file ~/
  done
  exit 0
fi


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
