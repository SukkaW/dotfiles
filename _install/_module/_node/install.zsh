#!/bin/zsh

echo -n "
============================================================
              Setting up NodeJS Environment
------------------------------------------------------------
* Installing NVM...
------------------------------------------------------------
"

curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

source $HOME/.zshrc

echo -n "
------------------------------------------------------------
* Import nvm script to .zshrc... "

if [ ! -n "$NVM_DIR" ]; then
    cat ./_install/_node/nvm.zshrc >> $HOME/.zshrc
fi

echo -n "Done!
------------------------------------------------------------
"

source $HOME/.zshrc

echo -n "
------------------------------------------------------------
* NVM Verision: "

command -v nvm

echo -n "
------------------------------------------------------------
* Installing NodeJS 10.8.0...
------------------------------------------------------------
"

nvm install v10.8.0

echo -n "
------------------------------------------------------------
* Set NodeJS 10.8.0 as default... "

nvm use v10.8.0
nvm alias default v10.8.0

echo -n "Done!
-----------------------------------------------------------
* Installing Yarn...
-----------------------------------------------------------
"

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install --no-install-recommends yarn

echo -n "
-----------------------------------------------------------
* Yarn Version: "

yarn --version

echo -n "
-----------------------------------------------------------
* Yarn Global Add those packages:

- http-server
- serve
- hexo-cli
- gulp-cli
- docsify-cli
- openload-cli
-----------------------------------------------------------
"

yarn global add http-server serve hexo-cli gulp-cli docsify-cli openload-cli

echo -n "
-----------------------------------------------------------
* Adding node package cli to PATH... "

cat ./_install/_node/yarn.zshrc >> $HOME/.zshrc
source $HOME/.zshrc

echo -n "Done!
"
