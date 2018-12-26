echo -n "
============================================================
              Setting up NodeJS Environment
------------------------------------------------------------
* NVM is already installed. Updade to latest...
------------------------------------------------------------
"

(
    cd "$NVM_DIR"
    git fetch --tags origin
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

echo "
------------------------------------------------------------
* Import nvm script to .zshrc... "

_NVM_RC=$(cat $HOME/.zshrc | grep 'export NVM_DIR=')

if [ ! -n "$_NVM_RC" ]; then
    cat ./_install/_module/node/nvm.zshrc >> $HOME/.zshrc
fi

echo -n "Done!
------------------------------------------------------------
"

source $HOME/.zshrc

./_install/_module/node/_node.sh
./_install/_module/node/_yarn.sh

echo -n "-----------------------------------------------------------
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

echo -n "
-----------------------------------------------------------
* Adding node package cli to PATH... "

cat ./_install/_node/yarn.zshrc | tee $HOME/.zshrc
source $HOME/.zshrc

echo -n "Done!
"