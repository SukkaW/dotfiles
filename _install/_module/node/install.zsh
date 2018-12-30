#!/bin/zsh

echo -n "
============================================================
              Setting up NodeJS Environment
------------------------------------------------------------
"

./_install/_module/node/_nvm.zsh
./_install/_module/node/_node.sh
./_install/_module/node/_yarn.sh

echo -n "
* Yarn Global Add those packages:

- http-server
- serve
- hexo-cli
- gulp-cli
- docsify-cli
- openload-cli
-----------------------------------------------------------
"

yarn global add http-server serve hexo-cli gulp-cli docsify-cli openload-cli
