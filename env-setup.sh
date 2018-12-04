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
----------"

sleep 1

echo -n "
  ____  
 |___ \ 
   __) |
  |__ < 
  ___) |
 |____/ 
----------"

sleep 1

echo -n "
  ___  
 |__ \ 
    ) |
   / / 
  / /_ 
 |____|
----------"

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
Install packages: zsh | curl | git | fonts-powerline | tree
-----------------------------------------------------------
"
sudo apt update
sudo apt install zsh -y
sudo apt install curl -y
sudo apt install git -y
sudo apt install fonts-powerline -y
sudo apt install tree -y

echo "==========================================================="
echo "Get Sukka/dotfiles from GitHub.com"
echo "-----------------------------------------------------------"

git clone https://github.com/SukkaW/dotfiles.git --depth=2
cd ./dotfiles
rm -rf .git

echo -n "
===========================================================
Set permission of all scripts...
-----------------------------------------------------------
"

find ./_install -type f -name "*.sh" | xargs chmod +x

echo -n "Done!
===========================================================
"

./_install/main.sh

echo -n "
===========================================================
Finish Sukka Env Setup! Do not forget those things:

- chsh -s /usr/bin/zsh
- npm login
- run_keybase
= Write netrc file
===========================================================
"
