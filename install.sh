#!/bin/bash

git clone https://github.com/ShumilinPavel/nx_bootcamp_nix_diary.git diary-tmp
mv diary-tmp/diary /usr/local/bin/
mv diary-tmp/.diaryrc $HOME/
mkdir $HOME/diary
mv diary-tmp/templates $HOME/diary/
rm -rf diary-tmp
