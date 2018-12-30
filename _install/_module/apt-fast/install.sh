#!/bin/bash

echo -n "
===========================================================
                  Installing apt-fast

* Import apt-fast.conf... "

sudo touch /etc/apt/apt-fast.conf
cat ./etc-conf/apt-fast.conf | sudo tee /etc/apt/apt-fast.conf >/dev/null

echo -n "Done!
* Adding apt-fast PPA...
-----------------------------------------------------------
"

sudo add-apt-repository ppa:apt-fast/stable
sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list
sudo apt-get update

echo -n "
-----------------------------------------------------------
* Installing apt-fast...
-----------------------------------------------------------
"

sudo apt-get -y install apt-fast
