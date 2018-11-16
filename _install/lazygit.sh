sudo add-apt-repository ppa:lazygit-team/release

echo -n "
-----------------------------------------------------------
Using Moruy PPA Proxy ...
----------------------------------------------------------
"

sudo sed -i "s/ppa\.launchpad\.net/lanuchpad.moruy.cn/g" /etc/apt/sources.list.d/*.list

sudo apt-get update
sudo apt-get install lazygit
