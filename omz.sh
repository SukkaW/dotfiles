sudo apt update
sudo apt install zsh
sudo apt install curl
sudo apt install fonts-powerline

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

cat zshrc/alias >> ~/.zshrc
cat zshrc/apt >> ~/.zshrc
cat zshrc/proxy >> ~/.zshrc
