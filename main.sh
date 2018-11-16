#!/usr/bin/bash

echo -n "
===========================================================
  ____          _     _ 
 / ___|  _   _ | | __| | __ __ _ 
 \___ \ | | | || |/ /| |/ // _\` |
  ___) || |_| ||   < |   <| (_| |
 |____/  \__,_||_|\_\|_|\_\\\\__,_|
===========================================================
"
echo -n "
!! ATTENTION !!

Before setting up Sukka Environment, make sure you are:
* Using ubuntu
* Have your /etc/apt/sources.list modified

The setup will begin in 5 seconds...
----------
"

sleep 1

echo -n "
  _____ 
 | ____|
 | |__  
 |___ \ 
  ___) |
 |____/ 
----------
"

sleep 1

echo -n "
  _  _   
 | || |  
 | || |_ 
 |__   _|
    | |  
    |_|  
----------
"

sleep 1

echo -n "
  ____  
 |___ \ 
   __) |
  |__ < 
  ___) |
 |____/ 
----------
"

sleep 1

echo -n "
  ___  
 |__ \ 
    ) |
   / / 
  / /_ 
 |____|
----------
"

sleep 1

echo -n "
  __ 
 /_ |
  | |
  | |
  | |
  |_|
"

sleep 1

echo -n "
----------
Here we go !
===========================================================
Install packages: zsh curl git fonts-powerline
"


sudo apt update
sudo apt install zsh
sudo apt install curl
sudo apt install fonts-powerline

