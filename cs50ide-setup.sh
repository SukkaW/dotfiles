#!/bin/bash

sudo sed -i 's|http://ppa.launchpad.net|http://launchpad.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://us-central1.gce.clouds.archive.ubuntu.com|http://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://asia-east1.gce.clouds.archive.ubuntu.com|http://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://security.ubuntu.com|http://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
