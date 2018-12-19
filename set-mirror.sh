#!/bin/bash

sudo sed -i 's|http://archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://security.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://security.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://downloads-distro.mongodb.org|https://mongodb-distro.mirror.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://us-east-1.ec2.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://us-east-1.ec2.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://us-central1.gce.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://us-central1.gce.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://us-central1.gce.clouds.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://us-central1.gce.clouds.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://asia-east1.gce.clouds.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://asia-east1.gce.clouds.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list.d/*.list

sudo sed -i 's|http://europe-west1.gce.clouds.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list
sudo sed -i 's|http://europe-west1.gce.clouds.archive.ubuntu.com|https://ubuntu.mirror.noc.one|g' /etc/apt/sources.list.d/*.list
