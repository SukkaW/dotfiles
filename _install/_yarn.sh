#!/bin/zsh

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install --no-install-recommends yarn

echo "-----------------------------------------------------------"
echo "Output Yarn Version"
echo "-----------------------------------------------------------"

yarn --version

echo -n "
-----------------------------------------------------------
Yarn Global add those packages:

- http-server
- serve
- hexo-cli
- gulp-cli
- docsify-cli
-----------------------------------------------------------
"

yarn global add http-server serve hexo-cli gulp-cli docsify-cli
