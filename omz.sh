sudo apt update
sudo apt install zsh
sudo apt install curl
sudo apt install fonts-powerline

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' $HOME/.zshrc

cat zshrc/alias >> $HOME/.zshrc
cat zshrc/apt >> $HOME/.zshrc
cat zshrc/proxy >> $HOME/.zshrc
