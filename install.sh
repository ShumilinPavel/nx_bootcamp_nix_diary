#!/bin/bash

git clone https://github.com/ShumilinPavel/nx_bootcamp_nix_diary.git $HOME/diary

if [[ $(grep -c "source $HOME/diary/diary.sh" $HOME/.bashrc) = 0 ]]
then
    echo "adding '$HOME/diary/diary.sh' in '$HOME/.bashrc'"
    echo "source $HOME/diary/diary.sh" >> $HOME/.bashrc
    source $HOME/.bashrc
fi

sudo apt-get install uuid-runtime
