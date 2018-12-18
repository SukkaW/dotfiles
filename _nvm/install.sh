#!/bin/bash

echo -n "
-----------------------------------------------------------
Installing NVM...
"

curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

echo -n "
* Import nvm script to .zshrc
"

cat ./_nvm/nvm.zshrc >> $HOME/.zshrc
source $HOME/.zshrc

echo -n "
* NVM Verision: "

command -v nvm

echo -n "
* Install NodeJS 10.8.0...
"

nvm install v10.8.0

nvm use v10.8.0

nvm alias default v10.8.0

echo -n "-----------------------------------------------------------
"