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

YOU ARE SETTING UP: Sukka Environment (ide50 ubuntu)

Before start, please make sure you are:

- Using ubuntu on ide50
===========================================================
* The setup will begin in 5 seconds... "

sleep 5

echo -n "Times up! Here we start!
===========================================================
* Setting up NOC.ONE Mirror...
-----------------------------------------------------------
"

curl -L https://git.io/noc.one | bash

echo -n "
-----------------------------------------------------------
                Install following packages

- zsh
- curl
- git
- tree
- python2.7
- python3-dev
- python3-pip
- python3-setuptools
- axel
-----------------------------------------------------------
"
sudo apt update
sudo apt install -y zsh curl git tree python2.7 python3-dev python3-pip python3-setuptools axel

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

./_install/_partial/ide50.zsh

echo -n "
-----------------------------------------------------------
                      Always use zsh
-----------------------------------------------------------
"

echo "bash -c zsh" >> $HOME/.bashrc

echo -n "
===========================================================
> Sukka Enviroment Setup finished!
> Do not forget run those things:

- git-config
===========================================================
"
