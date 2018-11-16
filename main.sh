#!/bin/bash

echo -n "
!! ATTENTION !!

Before setting up Sukka Environment, make sure you are:
* Using ubuntu
* Have your /etc/apt/sources.list modified

The setup will begin in 5 seconds...
----------
"

sleep 1

echo -n "
  _____ 
 | ____|
 | |__  
 |___ \ 
  ___) |
 |____/ 
----------
"

sleep 1

echo -n "
  _  _   
 | || |  
 | || |_ 
 |__   _|
    | |  
    |_|  
----------
"

sleep 1

echo -n "
  ____  
 |___ \ 
   __) |
  |__ < 
  ___) |
 |____/ 
----------
"

sleep 1

echo -n "
  ___  
 |__ \ 
    ) |
   / / 
  / /_ 
 |____|
----------
"

sleep 1

echo -n "
  __ 
 /_ |
  | |
  | |
  | |
  |_|
"

sleep 1

echo -n "
----------
Here we start...
===========================================================
Install packages: zsh | curl | git | fonts-powerline
-----------------------------------------------------------
"
sudo apt update
sudo apt install zsh -y
sudo apt install curl -y
sudo apt install git -y
sudo apt install fonts-powerline -y

echo "==========================================================="
echo "Get Sukka/dotfiles from GitHub.com"
echo "-----------------------------------------------------------"

git clone https://github.com/SukkaW/dotfiles.git --depth=2
cd ./dotfiles

echo -n "
===========================================================
  ____          _     _ 
 / ___|  _   _ | | __| | __ __ _ 
 \___ \ | | | || |/ /| |/ // _\` |
  ___) || |_| ||   < |   <| (_| |
 |____/  \__,_||_|\_\|_|\_\\\\__,_|
===========================================================
Set permission of all scripts...
"

find ./_install -type f -name "*.sh" | xargs chmod +x

echo "Done!"
echo "==========================================================="
echo "Install Oh-My-Zsh..."
echo "-----------------------------------------------------------"

./_install/omz.sh

echo "-----------------------------------------------------------"
echo "Oh-My-Zsh installed successfully!"
echo "-----------------------------------------------------------"
echo "Import _install/zshrc/main.rc"
echo "-----------------------------------------------------------"

cat ./_install/zshrc/main.rc >> $HOME/.zshrc

source ~/.zshrc

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

./_install/nvm.sh