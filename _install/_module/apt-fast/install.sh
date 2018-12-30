#!/bin/bash

echo -n "
===========================================================
                  Installing apt-fast

* Adding apt-fast PPA...
-----------------------------------------------------------
"

sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update

echo -n "
-----------------------------------------------------------
* Installing apt-fast...
-----------------------------------------------------------"

sudo apt-get -y install apt-fast

echo -n "
-----------------------------------------------------------
* Import apt-fast.conf... "

cat ./etc-conf/apt-fast.conf | sudo tee /etc/apt/apt-fast.conf

echo -n "Done!
"