#!/bin/zsh

./_install/_module/_omz/install.zsh
./_install/_module/_node/install.zsh

./_install/_module/_lazygit/install.sh
./_install/_module/_keybase/install.sh

echo -n "
===========================================================
              Import following sukka's zshrc

- apt
- alias
-----------------------------------------------------------
"

cat ./_zshrc/apt.zshrc >> $HOME/.zshrc
cat ./_zshrc/alias.zshrc >> $HOME/.zshrc

source $HOME/.zshrc

./_install/_module/_thefuck/install.sh

echo -n "
===========================================================
                      Upgrade packages
-----------------------------------------------------------
"

sudo apt update && sudo apt upgrade -y

pip install --upgrade pip

npm i -g npm
