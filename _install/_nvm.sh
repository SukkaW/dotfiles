#!/bin/zsh

curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

echo "-----------------------------------------------------------"
echo "Import _install/zshrc/nvm.rc"
echo "-----------------------------------------------------------"

cat ./_install/zshrc/nvm.rc >> $HOME/.zshrc

rezsh

echo "-----------------------------------------------------------"
echo "NVM Verision"
echo "-----------------------------------------------------------"

command -v nvm

echo "-----------------------------------------------------------"
echo "Install NodeJS 10.8.0"
echo "-----------------------------------------------------------"

nvm install v10.8.0

nvm use v10.8.0
