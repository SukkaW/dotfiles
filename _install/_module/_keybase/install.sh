#!/bin/bssh

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
"

sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f

echo -n "
-----------------------------------------------------------
* Clean up... "

rm -rf keybase_amd64.deb

echo -n "Done!
"
