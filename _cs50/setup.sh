#!/bin/bash

curl -o- https://raw.githubusercontent.com/SukkaW/dotfiles/master/_cs50/set-mirror.sh | bash

sudo apt update
sudo apt install -y curl git tree python2.7 python3-dev python3-pip python3-setuptools whois axel
sudo apt upgrade -y

# Upgrade NVM

(
  cd "$NVM_DIR"
  git fetch --tags origin
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

echo "curl -o- https://raw.githubusercontent.com/SukkaW/dotfiles/master/_cs50/set-mirror.sh | bash" > $HOME/.bashrc
echo "bash -c zsh" >> $HOME/.bashrc
