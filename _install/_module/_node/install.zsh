#!/bin/zsh

echo -n "
============================================================
              Setting up NodeJS Environment
------------------------------------------------------------
"

./_install/_module/_node/_nvm.zsh
./_install/_module/_node/_node.sh
./_install/_module/_node/_yarn.sh

echo -n "-----------------------------------------------------------
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

cat ./_install/_node/yarn.zshrc | tee $HOME/.zshrc
source $HOME/.zshrc

echo -n "Done!
"
