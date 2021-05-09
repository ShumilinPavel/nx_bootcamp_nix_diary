#!/bin/bash

git clone https://github.com/ShumilinPavel/nx_bootcamp_nix_diary.git $HOME/diary

mkdir $HOME/diary/notes
mkdir $HOME/diary/recycle-bin

if [[ $(grep -c "source $HOME/diary/diary.sh" $HOME/.bashrc) = 0 ]]
then
    echo "adding '$HOME/diary/diary.sh' in '$HOME/.bashrc'"
    echo "source $HOME/diary/diary.sh" >> $HOME/.bashrc
    source $HOME/.bashrc
fi

if [ ! -x "$(uuidgen)" ]
then
  echo 'uuidgen is not installed' >&2
  read -p "Do you want to install? [y/Y] " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      sudo apt-get install uuid-runtime
  else
      echo "Installation is aborted"
  fi
fi
