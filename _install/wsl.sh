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

cd $HOME
sudo apt update
sudo apt install -y zsh curl git tree android-tools-adb android-tools-fastboot python2.7 python3-dev python3-pip python3-setuptools whois axel

echo -n "
-----------------------------------------------------------
* Cloning Sukka/dotfiles Repo from GitHub.com
-----------------------------------------------------------
"

git clone https://github.com/SukkaW/dotfiles.git

cd ./dotfiles
rm -rf .git

echo -n "
===========================================================
                Installing Oh-My-Zsh...
-----------------------------------------------------------
"

curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

echo -n "
-----------------------------------------------------------
          Installing ZSH Custom Plugins & Themes

- zsh-autosuggestions
- zsh-syntax-highlighting
- sukka.zsh-theme
- proxy.zsh-plugin
- openload.zsh-plugin
-----------------------------------------------------------
"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp -r ./zsh-theme/. $HOME/.oh-my-zsh/custom/themes/
cp -r ./zsh-plugins/. $HOME/.oh-my-zsh/custom/plugins/


echo -n "
============================================================
              Setting up NodeJS Environment
------------------------------------------------------------
* Installing NVM...
------------------------------------------------------------
"

curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo -n "
------------------------------------------------------------
* NVM Verision: "

command -v nvm


echo -n "
* Installing NodeJS 10...
------------------------------------------------------------
"

nvm install 10

echo -n "
------------------------------------------------------------
* Set NodeJS 10 as default...
-----------------------------------------------------------
"

nvm use v10
nvm alias default v10

echo -n "
-----------------------------------------------------------
* NodeJS Version: "

node -v

echo -n "
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
===========================================================
                  Installing lazygit

* Adding lazygit PPA...
-----------------------------------------------------------
"

sudo add-apt-repository ppa:lazygit-team/release
sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list
sudo apt update

echo -n "
-----------------------------------------------------------
* Installing lazygit...
-----------------------------------------------------------
"

sudo apt install lazygit -y

echo -n "
===========================================================
                      Install keybase

* Download keybase package...
-----------------------------------------------------------
"

curl -O https://prerelease.keybase.io/keybase_amd64.deb

echo -n "
-----------------------------------------------------------
* Install keybase package...
-----------------------------------------------------------
"

sudo dpkg -i keybase_amd64.deb && sudo apt-get install -f

echo -n "
-----------------------------------------------------------
* Clean up... "

rm -rf keybase_amd64.deb

echo -n "Done!

===========================================================
                      Install thefuck
-----------------------------------------------------------
"

sudo pip3 install thefuck


echo -n "
===========================================================
                Install Google ci_editor

* Cloning google/ci_edit from GitHub.com
-----------------------------------------------------------
"

git clone https://github.com/google/ci_edit.git --depth=50

echo -n "
-----------------------------------------------------------
> You can run 'ci-edit-update' later to finish install.
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
