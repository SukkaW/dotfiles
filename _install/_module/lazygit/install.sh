#!/bin/bash

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
-----------------------------------------------------------"

sudo apt install lazygit -y
