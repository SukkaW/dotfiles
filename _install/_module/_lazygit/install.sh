#!/bin/bash
echo -n "
===========================================================
                  Installing lazygit
-----------------------------------------------------------
"

echo -e "* Adding lazygit PPA..."

sudo add-apt-repository ppa:lazygit-team/release

echo -e "* Using PPA Proxy..."

sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list

sudo apt update

echo -n "
* Installing lazygit..."

sudo apt install lazygit

echo -n "Done!
"