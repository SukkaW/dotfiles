curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

source $HOME/.zshrc

command -v nvm

nvm install node

nvm use node
