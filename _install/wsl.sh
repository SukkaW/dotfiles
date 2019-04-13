#!/bin/bash

sukkaEnvVersion="WSL Ubuntu"
sukkaEnvRequired=$(echo -n "
* Using ubuntu on wsl
* Have your /etc/apt/sources.list modified
")

start() {
    clear

    echo "==========================================================="
    echo "   _____       _    _            ______                    "
    echo "  / ____|     | |  | |          |  ____|                   "
    echo " | (___  _   _| | _| | ____ _   | |__   ______   __        "
    echo "  \___ \| | | | |/ / |/ / _\` |  |  __| |  _ \\ \\ / /     "
    echo "  ____) | |_| |   <|   < (_| |  | |____| | | \\ V /        "
    echo " |_____/ \__,_|_|\\_\\_|\\_\\__,_|  |______|_| |_|\\_/     "
    echo "                                                           "
    echo "==========================================================="
    echo "                !! ATTENTION !!"
    echo "YOU ARE SETTING UP: Sukka Environment (${sukkaEnvVersion})"
    echo "Before start, please make sure you are:"
    echo "${sukkaEnvRequired}"
    echo "==========================================================="
    echo ""
    echo -n "* The setup will begin in 5 seconds... "

    sleep 5

    echo -n "Times up! Here we start!"
    echo ""

    cd $HOME
}

install-linux-packages() {
    echo "==========================================================="
    echo "* Install following packages:"
    echo ""
    echo "  - zsh"
    echo "  - curl"
    echo "  - git"
    echo "  - tree"
    echo "  - android-tools-adb"
    echo "  - android-tools-fastboot"
    echo "  - python2.7"
    echo "  - python3-dev"
    echo "  - python3-pip"
    echo "  - python3-setuptools"
    echo "  - whois"
    echo "  - axel"
    echo "-----------------------------------------------------------"

    sudo apt-get update
    sudo apt-get install -y zsh curl git tree android-tools-adb android-tools-fastboot python2.7 python3-dev python3-pip python3-setuptools whois axel iputils-tracepath
}

clone-repo() {
    echo "-----------------------------------------------------------"
    echo "* Cloning Sukka/dotfiles Repo from GitHub.com"
    echo "-----------------------------------------------------------"

    git clone https://github.com/SukkaW/dotfiles.git

    cd ./dotfiles
    rm -rf .git
}


setup-omz() {
    echo "==========================================================="
    echo "                      Shells Enviroment"
    echo "-----------------------------------------------------------"
    echo "* Installing Oh-My-Zsh..."
    echo "-----------------------------------------------------------"

    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

    echo "-----------------------------------------------------------"
    echo "* Installing ZSH Custom Plugins & Themes:"
    echo ""
    echo "  - zsh-autosuggestions"
    echo "  - zsh-syntax-highlighting"
    echo "  - sukka.zsh-theme"
    echo "  - zsh-proxy.zsh-plugin"
    echo "  - openload.zsh-plugin"
    echo "-----------------------------------------------------------"

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/sukkaw/zsh-proxy.git ~/.oh-my-zsh/custom/plugins/zsh-proxy

    cp -r ./zsh-theme/. $HOME/.oh-my-zsh/custom/themes/
    cp -r ./zsh-plugins/. $HOME/.oh-my-zsh/custom/plugins/
}


install-nodejs() {
    install-nvm() {
        echo "-----------------------------------------------------------"
        echo "* Installing NVM..."
        echo "-----------------------------------------------------------"

        curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm@v0.33.11/install.sh | bash

        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

        echo "-----------------------------------------------------------"
        echo -n "* NVM Verision: "
        command -v nvm
    }

    install-node() {
        echo "-----------------------------------------------------------"
        echo "* Installing NodeJS 10..."
        echo "-----------------------------------------------------------"

        nvm install 10

        echo "-----------------------------------------------------------"
        echo "* Set NodeJS 10 as default..."
        echo "-----------------------------------------------------------"

        nvm use v10
        nvm alias default v10

        echo "-----------------------------------------------------------"
        echo -n "* NodeJS Version: "

        node -v
    }

    install-yarn() {
        echo "-----------------------------------------------------------"
        echo "* Installing Yarn..."
        echo "-----------------------------------------------------------"

        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt-get update && sudo apt-get install --no-install-recommends yarn

        echo "-----------------------------------------------------------"
        echo -n "* Yarn Version: "

        yarn --version
    }

    yarn-global-add() {
        echo "-----------------------------------------------------------"
        echo "* Yarn Global Add those packages:"
        echo ""
        echo "  - http-server"
        echo "  - serve"
        echo "  - hexo-cli"
        echo "  - gulp-cli"
        echo "  - docsify-cli"
        echo "  - openload-cli"
        echo "-----------------------------------------------------------"

        yarn global add http-server serve hexo-cli gulp-cli docsify-cli openload-cli now
    }


    echo "==========================================================="
    echo "              Setting up NodeJS Environment"

    install-nvm
    install-node
    install-yarn
    yarn-global-add
}

lazygit() {
    echo "==========================================================="
    echo "                  Installing lazygit                       "
    echo ""
    echo "* Adding lazygit PPA..."
    echo "-----------------------------------------------------------"

    sudo add-apt-repository ppa:lazygit-team/release
    sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list
    sudo apt-get update

    echo "-----------------------------------------------------------"
    echo "* Installing lazygit..."
    echo "-----------------------------------------------------------"

    sudo apt-get install lazygit -y
}

install-nali() {
    echo "==========================================================="
    echo "                   Installing Nali                         "
    echo ""
    echo "* Cloning SukkaW/Nali"
    echo "-----------------------------------------------------------"

    git clone https://github.com/sukkaw/nali.git --depth=10

    echo "-----------------------------------------------------------"
    echo "* Install Nali..."
    echo "-----------------------------------------------------------"
    ./configure
    make && sudo make install
    echo "-----------------------------------------------------------"
    echo "* Updating Nali IP Database..."
    echo "-----------------------------------------------------------"
    sudo nali-update
}

install-ctop() {
    sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -O /usr/local/bin/ctop
    sudo chmod +x /usr/local/bin/ctop
}

keybase() {
    echo "==========================================================="
    echo "                      Install keybase                      "
    echo ""
    echo "* Download keybase package..."
    echo "-----------------------------------------------------------"

    curl -O https://prerelease.keybase.io/keybase_amd64.deb

    echo "-----------------------------------------------------------"
    echo "* Install keybase package..."
    echo "-----------------------------------------------------------"

    sudo dpkg -i keybase_amd64.deb && sudo apt-get install -f
    sudo apt-get -f install

    echo "-----------------------------------------------------------"
    echo -n "* Clean up... "

    rm -rf keybase_amd64.deb

    echo -n "Done!"
    echo ""
}

thefuck() {
    echo "==========================================================="
    echo "                      Install thefuck                      "
    echo "-----------------------------------------------------------"

    sudo pip3 install thefuck
}


ci_editor() {
    echo "==========================================================="
    echo "                Install Google ci_editor"
    echo ""
    echo "* Cloning google/ci_edit from GitHub.com"
    echo "-----------------------------------------------------------"

    cd $HOME
    git clone https://github.com/google/ci_edit.git --depth=50

    echo "-----------------------------------------------------------"
    echo "> You can run 'ci-edit-update' later to finish install."

    sleep 3
    cd dotfiles
}

zshrc() {
    echo "==========================================================="
    echo "                  Import sukka env zshrc                   "
    echo "-----------------------------------------------------------"

    cat ./_zshrc/wsl-ubuntu.zshrc > $HOME/.zshrc
}

upgrade-packages() {
    echo "==========================================================="
    echo "                      Upgrade packages                     "
    echo "-----------------------------------------------------------"

    sudo apt-get update && sudo apt-get upgrade -y
    pip install --upgrade pip
    npm i -g npm
}

chmod() {
    sudo chmod u+s /bin/ping
    sudo chmod u+s /usr/sbin/traceroute
}

finish() {
    echo "==========================================================="
    echo "> Sukka Enviroment Setup finished!"
    echo "> Do not forget run those things:"
    echo ""
    echo "- chsh -s /usr/bin/zsh"
    echo "- npm login"
    echo "- run_keybase"
    echo "- ci-edit-update"
    echo "- oload-config"
    echo "- git-config"
    echo "- we .netrc"
    echo "==========================================================="
}

start
install-linux-packages
clone-repo
setup-omz
install-nodejs
lazygit
install-nali
install-ctop
thefuck
keybase
ci_editor
zshrc
chmod
upgrade-packages
finish
