#!/bin/zsh

echo -n "
* Installing NVM...
------------------------------------------------------------
"

curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

source $HOME/.zshrc

echo -n "
------------------------------------------------------------
* Import nvm script to .zshrc... "

_NVM_RC=$(cat $HOME/.zshrc | grep 'export NVM_DIR')

if [ "$_NVM_RC" == "" ]; then
    cat ./_install/_module/node/nvm.zshrc | tee $HOME/.zshrc
fi

echo -n "Done!
------------------------------------------------------------
"

source $HOME/.zshrc

echo -n "
------------------------------------------------------------
* NVM Verision: "

command -v nvm
