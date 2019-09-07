# =================================================== #
#   _____       _    _            ______              #
#  / ____|     | |  | |          |  ____|             #
# | (___  _   _| | _| | ____ _   | |__   ______   __  #
#  \___ \| | | | |/ / |/ / _\`|  |  __| |  _ \ \ / /  #
#  ____) | |_| |   <|   < (_| |  | |____| | | \ V /   #
# |_____/ \__,_|_|\_\_|\_\__,_|  |______|_| |_|\_/    #
#                                                     #
# =================================================== #

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
export UPDATE_ZSH_DAYS=4

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

ZSH_DISABLE_COMPFIX=true

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

export NVM_AUTO_USE=true

plugins=(
  zsh-proxy
  openload
  zsh-autosuggestions
  git
  zsh-syntax-highlighting
  zsh-ipip
  zsh-nvm
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

export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/c/bin/platform-tools"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/c/bin
export DISPLAY=127.0.0.1:0.0
export PULSE_SERVER=tcp:127.0.0.1
alias rezsh="source $HOME/.zshrc"

alias rmrf="rm -rf"
alias gitcm="git commit -m"
alias gitp="git push"
alias gita="git add -a"
alias gitall="git add ."
alias lg='lazygit'

alias ping="nali-ping"
alias dig="nali-dig"
alias traceroute="nali-traceroute"
alias tracepath="nali-tracepath"
alias nslookup="nali-nslookup"
alias nali-update="sudo nali-update"

eval $(thefuck --alias)

ci-edit-update() {
    (
        cd "$HOME/ci_edit"
        git pull
    ) && sudo "$HOME/ci_edit/install.sh"
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
alias e="explorer.exe ."
alias code="code ."

eval $(thefuck --alias)

goclean() {
  local pkg=$1; shift || return 1
  local ost
  local cnt
  local scr

  # Clean removes object files from package source directories (ignore error)
  go clean -i $pkg &>/dev/null

  # Set local variables
  [[ "$(uname -m)" == "x86_64" ]] \
  && ost="$(uname)" && ost="${ost,,}_amd64" \
  && cnt="${pkg//[^\/]}"

  # Delete the source directory and compiled package directory(ies)
  if (("${#cnt}" == "2")); then
    rm -rf "${GOPATH%%:*}/src/${pkg%/*}"
    rm -rf "${GOPATH%%:*}/pkg/${ost}/${pkg%/*}"
  elif (("${#cnt}" > "2")); then
    rm -rf "${GOPATH%%:*}/src/${pkg%/*/*}"
    rm -rf "${GOPATH%%:*}/pkg/${ost}/${pkg%/*/*}"
  fi

  # Reload the current shell
  source ~/.zshrc
}

ssh_start() {
  sshd_status=$(service ssh status)
  if [[ $sshd_status = *"is not running"* ]]; then
    sudo service ssh --full-restart
  fi
}

# source /home/sukka/.gvm/scripts/gvm
