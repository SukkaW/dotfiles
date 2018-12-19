#!/bin/bash

echo -n "
* Installing NodeJS 10.8.0...
------------------------------------------------------------
"

nvm install v10.8.0

echo -n "
------------------------------------------------------------
* Set NodeJS 10.8.0 as default... "

nvm use v10.8.0
nvm alias default v10.8.0

echo -n "Done!
-----------------------------------------------------------
* NodeJS Version: "

node -v
