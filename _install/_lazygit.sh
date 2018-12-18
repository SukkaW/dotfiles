#!/bin/zsh

sudo add-apt-repository ppa:lazygit-team/release

echo -n "
-----------------------------------------------------------
Using PPA Proxy ...
----------------------------------------------------------
"

sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list

sudo apt update
sudo apt install lazygit
