#!/bin/bash

read -p "Do you want to uninstall Diary? [y/Y] " -n 1 -r
echo    # (optional) move to a new line 
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ -f  $HOME/diary/.diaryrc ]]
    then
        source $HOME/diary/.diaryrc
        rm -rf $NOTES_DIR
        rm -rf $TEMPLATES_DIR
        rm -rf $RECYCLE_BIN_DIR
    fi

    if [[ $(grep -c "source $HOME/diary/diary.sh" $HOME/.bashrc) != 0 ]]
    then
        grep -v "source $HOME/diary/diary.sh" $HOME/.bashrc > $HOME/.bashrc-tmp
        mv $HOME/.bashrc-tmp $HOME/.bashrc
    fi

    rm -rf $HOME/diary
else
    echo "Canceled"
fi
