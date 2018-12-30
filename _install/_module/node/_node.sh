#!/bin/bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo -n "
* Installing NodeJS 10...
------------------------------------------------------------
"

nvm install 10

echo -n "
------------------------------------------------------------
* Set NodeJS 10 as default...
-----------------------------------------------------------
"

nvm use v10
nvm alias default v10

echo -n "
-----------------------------------------------------------
* NodeJS Version: "

node -v
