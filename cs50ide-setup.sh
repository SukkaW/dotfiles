#!/bin/bash

sudo sed -i 's|http://ppa.launchpad.net|http://launchpad.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://security.ubuntu.com|http://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://us-central1.gce.clouds.archive.ubuntu.com|http://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://asia-east1.gce.clouds.archive.ubuntu.com|http://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://europe-west1.gce.clouds.archive.ubuntu.com|http://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list

sudo apt update
sudo apt install -y curl git tree python2.7 python3-dev python3-pip python3-setuptools whois axel
