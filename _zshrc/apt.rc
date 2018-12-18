aptupd () {
  echo "====================="
  echo "sudo apt update"
  echo "---------------------"
  sudo apt update
  echo "---------------------"
  echo "sudo apt list --upgradable"
  echo "---------------------"
  sudo apt list --upgradable
  echo "====================="
}

alias aptupg='sudo apt upgrade -y'
alias apti='sudo apt install'
alias apts='sudo apt search'

aptcn () {
  echo "====================="
  echo "Use the mirror hosted in China"
  echo "====================="
  sudo sed -i "s|https://mirrors.noc.one|https://mirrors.shu.edu.cn|g" /etc/apt/sources.list
  sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.ustclug.org|g" /etc/apt/sources.list.d/*.list
  sudo sed -i "s|https://launchpad.proxy.noc.one|https://launchpad.proxy.ustclug.org|g" /etc/apt/sources.list.d/*.list
}

aptcf () {
  echo "====================="
  echo "Use the mirror hosted on Cloudflare"
  echo "====================="
  sudo sed -i "s|https://mirrors.shu.edu.cn|https://mirrors.noc.one|g" /etc/apt/sources.list
  sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list
  sudo sed -i "s|https://launchpad.proxy.ustclug.org|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list
}
