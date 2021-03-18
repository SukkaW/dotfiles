#!/bin/zsh

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "No macOS detected!"
  exit 1
fi

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
  echo "        !! ATTENTION !!"
  echo "YOU ARE SETTING UP: Sukka Environment (macOS)"
  echo "==========================================================="
  echo ""
  echo -n "* The setup will begin in 5 seconds... "

  sleep 5

  echo -n "Times up! Here we start!"
  echo ""

  cd $HOME
}

# xcode command tool will be installed during homebrew installation
install_homebrew() {
  echo "==========================================================="
  echo "                     Install Homebrew                      "
  echo "-----------------------------------------------------------"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

install_packages() {
  __pkg_to_be_installed=(
    zsh
    curl-openssl
    cmake
    wget
    git
    tree
    pyenv
    axel
    bind
    neofetch
    ncdu
    n
    thefuck
    unrar
    telnet
    jq
    whois
    mas
    imagemagick
    nmap
  )

  __casks_to_be_installed=(
    android-platform-tools
    iina
    telegram-desktop
    iterm2
    textmate
    keybase
    maczip
    keka
    kekaexternalhelper
    typora
    google-chrome
    firefox
    upic
    motrix
    sensiblesidebuttons
    visual-studio-code
    neteasemusic
    snipaste
    surge
    hackintool
    monitorcontrol
    1password
    switchhosts
    scroll-reverser
    osxfuse
    # Quick Look Plugin
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlstephen
    qlvideo
    quicklook-json
    quicklookase
    webpquicklook
    sogouinput
  )

  __taps_to_be_installed=(
    github/gh/gh
    jesseduffield/lazygit/lazygit
    font-consolas-for-powerline
  )

  echo "==========================================================="
  echo "* Install following packages:"
  echo ""

  for __pkg ($__pkg_to_be_installed); do
    echo "  - ${__pkg}"
  done

  for __cask ($__casks_to_be_installed); do
    echo "  - ${__cask} (cask)"
  done

  for __cask ($__casks_to_be_installed); do
    echo "  - ${__cask} (cask)"
  done

  for __tap ($__taps_to_be_installed); do
    echo "  - ${__tap} (tap)"
  done

  echo "-----------------------------------------------------------"

  brew update

  for __pkg ($__pkg_to_be_installed); do
    brew install ${__pkg}
  done

  if [ "$CI" != "true" ]; then
    for __cask ($__casks_to_be_installed); do
      brew install ${__cask} --cask
    done
  else
    echo "CI Environment detected, skip brew cask"
  fi

  for __tap ($__taps_to_be_installed); do
    brew install ${__tap}
  done
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
  echo "  - fast-syntax-highlighting"
  echo "  - zsh-gitcd"
  echo "  - p10k zsh-theme"
  echo "  - zsh-z"
  echo "-----------------------------------------------------------"

  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  git clone https://github.com/sukkaw/zsh-gitcd.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-gitcd
  git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z
}

install-nodejs() {
  echo "==========================================================="
  echo "              Setting up NodeJS Environment"

  export N_PREFIX="$HOME/.n"
  export N_PRESERVE_NPM=0
  export PATH="$N_PREFIX/bin:$PATH"

  # Set NPM Global Path
  export NPM_CONFIG_PREFIX="$HOME/.npm-global"
  # Create .npm-global folder if not exists
  [[ ! -d "$HOME/.npm-global" ]] && mkdir -p $HOME/.npm-global

  echo "-----------------------------------------------------------"
  echo "* Installing NodeJS LTS..."
  echo "-----------------------------------------------------------"

  n lts

  echo "-----------------------------------------------------------"
  echo -n "* NodeJS Version: "

  node -v

  __npm_global_pkgs=(
    @cloudflare/wrangler
    @upimg/cli
    cf-firewall-rules-generator
    http-server
    gulp-cli
    hexo-cli
    ipip-cli
    nali-cli
    vercel
    npm-why
    pnpm
    serve
    surge
    npm
    ts-node
    typescript
  )

  echo "-----------------------------------------------------------"
  echo "* npm install global packages:"
  echo ""

  for __npm_pkg ($__npm_global_pkgs); do
    echo "  - ${__npm_pkg}"
  done

  echo "-----------------------------------------------------------"

  for __npm_pkg ($__npm_global_pkgs); do
    npm i -g ${__npm_pkg}
  done
}

install-goenv() {
  echo "==========================================================="
  echo "                   Install syndbg/goenv"
  echo "-----------------------------------------------------------"

  git clone https://github.com/syndbg/goenv.git $HOME/.goenv
}

ci_editor() {
  echo "==========================================================="
  echo "                Install Google ci_editor"
  echo ""
  echo "* Cloning google/ci_edit from GitHub.com"
  echo "-----------------------------------------------------------"

  cd $HOME
  git clone https://github.com/google/ci_edit.git --depth=5

  echo "-----------------------------------------------------------"
  echo "> You can run 'ci-edit-update' later to finish install."

  sleep 5
}

ioio() {
  echo "==========================================================="
  echo "                 Install Rehabman ioio"
  echo "-----------------------------------------------------------"

  wget https://bitbucket.org/RehabMan/os-x-ioio/downloads/RehabMan-ioio-2014-0122.zip
  mkdir -p ioio
  unzip -o RehabMan-ioio-2014-0122.zip -d ioio

  \cp -rf ./ioio/Release/ioio $HOME/bin

  rm -rf ioio
}

zshrc() {
  echo "==========================================================="
  echo "                  Import sukka env zshrc                   "
  echo "-----------------------------------------------------------"

  cat $HOME/dotfiles/_zshrc/macos.zshrc > $HOME/.zshrc
  cat $HOME/dotfiles/p10k/.p10k.zsh > $HOME/.p10k.zsh
}

vimrc() {
  echo "==========================================================="
  echo "                  Import sukka env vimrc                   "
  echo "-----------------------------------------------------------"

  cat $HOME/dotfiles/vim/.vimrc > $HOME/.vimrc
}

fix_home_end_keybinding() {
  mkdir -p $HOME/Library/KeyBindings/
  echo "{
    \"\UF729\"  = moveToBeginningOfLine:; // home
    \"\UF72B\"  = moveToEndOfLine:; // end
    \"$\UF729\" = moveToBeginningOfLineAndModifySelection:; // shift-home
    \"$\UF72B\" = moveToEndOfLineAndModifySelection:; // shift-end
  }" > $HOME/Library/KeyBindings/DefaultKeyBinding.dict
}

finish() {
  echo "==========================================================="
  echo -n "* Clean up..."

  cd $HOME
  rm -rf $HOME/dotfiles

  echo "Done!"
  echo ""
  echo "> Sukka Enviroment Setup finished!"
  echo "> Do not forget run those things:"
  echo ""
  echo "- chsh -s /usr/bin/zsh"
  echo "- npm login"
  echo "- ci-edit-update"
  echo "- oload-config"
  echo "- git-config"
  echo "* open vim and run :PlugInstall"
  echo "==========================================================="

  cd $HOME
}

start
install_homebrew
install_packages
clone-repo
setup-omz
install-nodejs
ci_editor
ioio
fix_home_end_keybinding
zshrc
finish
