#!/bin/bash

echo -n "
===========================================================
   _____       _    _            ______
  / ____|     | |  | |          |  ____|
 | (___  _   _| | _| | ____ _   | |__   ______   __
  \___ \| | | | |/ / |/ / _\` |  |  __| |  _ \\ \\ / /
  ____) | |_| |   <|   < (_| |  | |____| | | \\ V /
 |_____/ \__,_|_|\\_\\_|\\_\\__,_|  |______|_| |_|\\_/

===========================================================
                    !! ATTENTION !!

YOU ARE SETTING UP: Sukka Environment (WSL Ubuntu)

Before start, please make sure you are:

- Using ubuntu on wsl
- Have your /etc/apt/sources.list modified
===========================================================
* The setup will begin in 5 seconds... "

sleep 5

echo -n "Times up! Here we start!
===========================================================
                Install following packages

- zsh
- curl
- git
- tree
- android-tools-adb
- android-tools-fastboot
- python2.7
- python3-dev
- python3-pip
- python3-setuptools
- whois
- axel
-----------------------------------------------------------
"
sudo apt update
sudo apt install -y zsh curl git tree android-tools-adb android-tools-fastboot python2.7 python3-dev python3-pip python3-setuptools whois axel

echo -n "
-----------------------------------------------------------
* Cloning Sukka/dotfiles Repo from GitHub.com
-----------------------------------------------------------

"

git clone https://github.com/SukkaW/dotfiles.git -b refactor/module

cd ./dotfiles
rm -rf .git

echo -n "
-----------------------------------------------------------
* Set permission of all scripts... "

find ./_install/_partial -type f -name "*.sh" | xargs chmod +x
find ./_install/_partial -type f -name "*.zsh" | xargs chmod +x
find ./_install/_module -type f -name "*.sh" | xargs chmod +x
find ./_install/_module -type f -name "*.zsh" | xargs chmod +x

echo -n "Done!
-----------------------------------------------------------
"

./_install/_partial/wsl.zsh

echo -n "
===========================================================
> Sukka Enviroment Setup finished!
> Do not forget run those things:

- chsh -s /usr/bin/zsh
- npm login
- run_keybase
- ci-edit-update
- oload-config
- git-config
- we .netrc
===========================================================
"
