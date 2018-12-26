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
* Check .oh-my-zsh custom directories tree
-----------------------------------------------------------
"

tree $HOME/.oh-my-zsh/custom/

echo -n "
-----------------------------------------------------------
"

source $HOME/.zshrc
