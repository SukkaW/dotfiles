#!/bin/zsh

echo -n "
===========================================================
                Installing Oh-My-Zsh...
-----------------------------------------------------------
"

curl -fsSL http://cdn.jsdelivr.net/gh/robbyrussell/oh-my-zsh@master/tools/install.sh | zsh -c

echo -n "
-----------------------------------------------------------
* Installing custom themes and plugins... "

cp -r ./zsh-theme/. $HOME/.oh-my-zsh/custom/themes/
cp -r ./zsh-plugins/. $HOME/.oh-my-zsh/custom/plugins/

echo -n "Done!
* Choose sukka.zsh-theme... "

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="sukka"/g' $HOME/.zshrc

echo -n "Done!
* Enable cusotm zsh plugins... "

sed -i 's|plugins=(|plugins=(proxy openload|g' $HOME/.zshrc

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
