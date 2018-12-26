# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/sukka/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="sukka"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  proxy
  openload
  zsh-autosuggestions
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# =================================================== #
#   _____       _    _            ______              #
#  / ____|     | |  | |          |  ____|             #
# | (___  _   _| | _| | ____ _   | |__   ______   __  #
#  \___ \| | | | |/ / |/ / _\`|  |  __| |  _ \ \ / /  #
#  ____) | |_| |   <|   < (_| |  | |____| | | \ V /   #
# |_____/ \__,_|_|\_\_|\_\__,_|  |______|_| |_|\_/    #
#                                                     #
# =================================================== #

# ------------------------------ NVM

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Calling nvm use automatically in a directory with a .nvmrc file
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

nvm-update() {
    (
        cd "$NVM_DIR"
        git fetch --tags origin
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh"
}

export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias rezsh="source $HOME/.zshrc"

alias rmrf "rm -rf"
alias gitcm "git commit -m"
alias gitp "git push"
alias gita "git add -a"
alias gitall "git add ."
alias lg='lazygit'
alias myip='check_ip'

eval $(thefuck --alias)

ci-edit-update() {
    (
        cd "$HOME/ci_edit"
        git pull
    ) && \. sudo "$HOME/ci_edit/install.sh"
}

git-config() {
    echo -n "
===================================
      * Git Configuration *
-----------------------------------
Please input Git Username: "

    read username

    echo -n "
-----------------------------------
Please input Git Email: "

    read email

    echo -n "
-----------------------------------
Done!
===================================
"

    git config --global user.name "${username}"
    git config --global user.email "${email}"

}

aptupd () {
    echo -n "
===================================
* Execute: sudo apt update
-----------------------------------
"

    sudo apt update

    echo -n "
-----------------------------------
* Execute: sudo apt list --upgradable
-----------------------------------
"

    sudo apt list --upgradable

    echo -n "
===================================
"

}

alias aptupg='sudo apt upgrade -y'
alias apti='sudo apt install'
alias apts='sudo apt search'

aptcn () {
  echo -n "
===================================
Use the mirror hosted in China:

- Ubuntu Package: https://mirrors.shu.edu.cn
- PPA: https://launchpad.proxy.ustclug.org
-----------------------------------
Modifying sources list files... "
    # Ubuntu Packages
    sudo sed -i "s|https://mirrors.noc.one|https://mirrors.shu.edu.cn|g" /etc/apt/sources.list
    sudo sed -i "s|https://mirrors.noc.one|https://mirrors.shu.edu.cn|g" /etc/apt/sources.list.d/*.list
    # PPA Proxy
    sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.ustclug.org|g" /etc/apt/sources.list
    sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.ustclug.org|g" /etc/apt/sources.list.d/*.list
    sudo sed -i "s|https://launchpad.proxy.noc.one|https://launchpad.proxy.ustclug.org|g" /etc/apt/sources.list
    sudo sed -i "s|https://launchpad.proxy.noc.one|https://launchpad.proxy.ustclug.org|g" /etc/apt/sources.list.d/*.list

    echo -n "Done!
"
}

aptcf () {
  echo -n "
===================================
Use the mirror hosted by NOC.ONE:

- Ubuntu Package: https://ubuntu.mirror.noc.one
- PPA: https://launchpad.proxy.noc.one
-----------------------------------
Modifying sources list files... "

    # Ubuntu Packages
    sudo sed -i "s|https://mirrors.shu.edu.cn|https://ubuntu.mirror.noc.one|g" /etc/apt/sources.list
    sudo sed -i "s|https://mirrors.shu.edu.cn|https://ubuntu.mirror.noc.one|g" /etc/apt/sources.list.d/*.list
    # PPA Proxy
    sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list
    sudo sed -i "s|http://ppa.launchpad.net|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list
    sudo sed -i "s|https://launchpad.proxy.ustclug.org|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list
    sudo sed -i "s|https://launchpad.proxy.ustclug.org|https://launchpad.proxy.noc.one|g" /etc/apt/sources.list.d/*.list
}

eval $(thefuck --alias)
