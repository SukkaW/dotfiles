#!/bin/zsh

echo -n "
===========================================================
  ____          _     _ 
 / ___|  _   _ | | __| | __ __ _ 
 \___ \ | | | || |/ /| |/ // _\` |
  ___) || |_| ||   < |   <| (_| |
 |____/  \__,_||_|\_\|_|\_\\\\__,_|
===========================================================
"

echo "Install Oh-My-Zsh..."
echo "-----------------------------------------------------------"

./_install/_omz.sh

echo "-----------------------------------------------------------"
echo "Oh-My-Zsh installed successfully!"
echo "-----------------------------------------------------------"
echo "Import _install/zshrc/main.rc"
echo "-----------------------------------------------------------"

cat ./zshrc/main.rc >> $HOME/.zshrc

source $HOME/.zshrc

echo "-----------------------------------------------------------"
echo "Test command: rezsh"
echo "-----------------------------------------------------------"

rezsh

echo -n "
===========================================================
Setup NVM & NodeJS & Yarn...
-----------------------------------------------------------
Installing NVM ...
----------------------------------------------------------
"

./_install/_nvm.sh

echo -n "
-----------------------------------------------------------
Installing Yarn ...
----------------------------------------------------------
"

./_install/_yarn.sh

echo -n "
===========================================================
Install lazygit
-----------------------------------------------------------
"

./_install/_lazygit.sh
