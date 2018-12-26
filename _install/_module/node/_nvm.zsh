#!/bin/zsh

echo -n "
* Installing NVM...
------------------------------------------------------------
"

curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

source $HOME/.zshrc

echo -n "
------------------------------------------------------------
* NVM Verision: "

command -v nvm
