curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

cat zshrc/nvm >> ~/.zshrc

source ~/.zshrc

command -v nvm

nvm install node

nvm use node
