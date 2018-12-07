#!/bin/zsh

sh -c "$(curl -fsSL http://cdn.jsdelivr.net/gh/robbyrussell/oh-my-zsh@master/tools/install.sh)"

echo -n "
-----------------------------------------------------------
Install sukka.zsh-theme ...
----------------------------------------------------------
"

touch $HOME/.oh-my-zsh/themes/sukka.zsh-theme

cat ./zsh-theme/sukka.zsh-theme > $HOME/.oh-my-zsh/themes/sukka.zsh-theme

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="sukka"/g' $HOME/.zshrc
