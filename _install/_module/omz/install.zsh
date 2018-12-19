#!/bin/zsh

echo -n "
===========================================================
                Installing Oh-My-Zsh...
-----------------------------------------------------------
"

curl -fsSL http://cdn.jsdelivr.net/gh/robbyrussell/oh-my-zsh@master/tools/install.sh | bash

echo -n "
-----------------------------------------------------------
          Installing ZSH Custom Plugins & Themes

- zsh-autosuggestions
- zsh-syntax-highlighting
- sukka.zsh-theme
- proxy.zsh-plugin
- openload.zsh-plugin
-----------------------------------------------------------
"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp -r ./zsh-theme/. $HOME/.oh-my-zsh/custom/themes/
cp -r ./zsh-plugins/. $HOME/.oh-my-zsh/custom/plugins/

echo -n "
-----------------------------------------------------------
* Choose sukka.zsh-theme... "

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="sukka"/g' $HOME/.zshrc

echo -n "Done!
* Enable cusotm zsh plugins... "

sed -i 's|plugins=(|plugins=(proxy openload zsh-autosuggestions|g' $HOME/.zshrc
sed -i 's|  git|  git zsh-syntax-highlighting|g' $HOME/.zshrc

echo -n "Done!
* Check .oh-my-zsh directories tree:
-----------------------------------------------------------
"

tree $HOME/.oh-my-zsh/custom/

echo -n "
-----------------------------------------------------------
* Check .zshrc file:
-----------------------------------------------------------
"

cat $HOME/.zshrc

echo -n "
-----------------------------------------------------------
"

source $HOME/.zshrc
