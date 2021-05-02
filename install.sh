#!/bin/bash

git clone https://github.com/ShumilinPavel/nx_bootcamp_nix_diary.git diary-tmp
cd diary-tmp
mv diary /usr/local/bin/
mv .diaryrc $HOME/
mkdir $HOME/diary
mv templates $HOME/diary/
rm -rf .