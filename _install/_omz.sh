#!/bin/zsh

sh -c "$(curl -fsSL http://cdn.jsdelivr.net/gh/robbyrussell/oh-my-zsh@master/tools/install.sh)"

echo -n "
-----------------------------------------------------------
Install sukka.zsh-theme and custom pkugins ...
----------------------------------------------------------
"

touch $HOME/.oh-my-zsh/themes/sukka.zsh-theme

cp -r ./zsh-theme/. $HOME/.oh-my-zsh/custom/themes/
cp -r ./zsh-plugins/. $HOME/.oh-my-zsh/custom/plugins/

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="sukka"/g' $HOME/.zshrc

sed -i 's|plugins=(|plugins=(\n  proxy|g' $HOME/.zshrc

tree $HOME/.oh-my-zsh/custom/

cat $HOME/.zshrc
