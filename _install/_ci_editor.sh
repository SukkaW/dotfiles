#!/bin/zsh

git clone https://github.com/google/ci_edit.git --depth=2

cd ci_edit

sudo ./install.sh

return 0

cd ..