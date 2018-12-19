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

if [ ! -n "$NVM_DIR" ]; then
    cat ./_install/_module/node/nvm.zshrc | tee $HOME/.zshrc
fi

cat $HOME/.zshrc

echo -n "Done!
------------------------------------------------------------
"

source $HOME/.zshrc

echo -n "
------------------------------------------------------------
* NVM Verision: "

command -v nvm
