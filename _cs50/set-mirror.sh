#!/bin/bash

sudo sed -i 's|http://ppa.launchpad.net|https://launchpad.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://security.ubuntu.com|https://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://us-central1.gce.clouds.archive.ubuntu.com|https://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://asia-east1.gce.clouds.archive.ubuntu.com|https://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
sudo sed -i 's|http://europe-west1.gce.clouds.archive.ubuntu.com|https://mirrors.speedtests.ml|g' /etc/apt/sources.list.d/*.list
