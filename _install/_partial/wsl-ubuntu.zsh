#!/bin/zsh

./_install/_module/omz/install.zsh

./_install/_module/node/install.zsh

./_install/_module/lazygit/install.sh
./_install/_module/keybase/install.sh

./_install/_module/thefuck/install.sh

echo -n "
===========================================================
                  Import sukka env zshrc
-----------------------------------------------------------
"

cat ./_zshrc/wsl-ubuntu.zshrc > $HOME/.zshrc

source $HOME/.zshrc

echo -n "
===========================================================
                      Upgrade packages
-----------------------------------------------------------
"

sudo apt update && sudo apt upgrade -y

pip install --upgrade pip

npm i -g npm
