# =================================================== #
#   _____       _    _            ______              #
#  / ____|     | |  | |          |  ____|             #
# | (___  _   _| | _| | ____ _   | |__   ______   __  #
#  \___ \| | | | |/ / |/ / _\`|  |  __| |  _ \ \ / /  #
#  ____) | |_| |   <|   < (_| |  | |____| | | \ V /   #
# |_____/ \__,_|_|\_\_|\_\__,_|  |______|_| |_|\_/    #
#                                                     #
# =================================================== #

# For Performance Debug purpose
# Set to 1 to enable profiling
SUKKA_ENABLE_PERFORMANCE_PROFILING=0

if (( $SUKKA_ENABLE_PERFORMANCE_PROFILING )); then
    rm -rf zsh_profile*
    zmodload zsh/zprof

    zmodload zsh/datetime

    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '
    __sukka_zsh_profiling_logfile=$(mktemp zsh_profile.XXXXXX)
    echo "Logging to $__sukka_zsh_profiling_logfile"
    exec 3>&2 2>$__sukka_zsh_profiling_logfile

    setopt XTRACE
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

#ZSH_THEME="sukka"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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

# Enable insecure directories and files from custom plugins
# ZSH_DISABLE_COMPFIX="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Cache Freq Use Variables
## Homebrew prefix
__SUKKA_HOMWBREW__PREFIX="/usr/local"
## pyenv prefix
__SUKKA_HOMEBREW_PYENV_PREFIX="/usr/local/opt/pyenv"
## Box Name used for my zsh-theme
# __SUKKA_BOX_NAME=${HOST/.local/}
# Homebrew zsh completion path
__SUKKA_HOMEBREW_ZSH_COMPLETION="${__SUKKA_HOMWBREW__PREFIX}/share/zsh/site-functions"
# zsh-completion fpath
__SUKKA_ZSH_COMPLETION_SRC="$ZSH/custom/plugins/zsh-completions/src"

# This speed up zsh-autosuggetions by a lot
export ZSH_AUTOSUGGEST_USE_ASYNC="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
    # osx
    zsh-autosuggestions
    # git
    # zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-gitcd
    # zsh-completion will be added to FPATH directly
    # zsh-completions
    zsh-z
    # zsh-interactive-cd
    fzf-tab
)

# ZSH completions
## For homebrew, is must be added before oh-my-zsh is called.
## https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
## https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/github/README.md#homebrew-installation-note
## Add a check avoiding duplicated fpath
if (( ! $FPATH[(I)${__SUKKA_HOMEBREW_ZSH_COMPLETION}] && $+commands[brew] )) &>/dev/null; then
    FPATH=${__SUKKA_HOMWBREW__PREFIX}/share/zsh/site-functions:$FPATH
fi
## https://github.com/zsh-users/zsh-completions
[[ -d ${__SUKKA_ZSH_COMPLETION_SRC} ]] && FPATH="${__SUKKA_ZSH_COMPLETION_SRC}:$FPATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if (( $#SSH_CONNECTION )); then
    export EDITOR='vim'
else
    export EDITOR='nano'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set NPM Global Path
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
# Create .npm-global folder if not exists
[[ ! -d "$HOME/.npm-global" ]] && mkdir -p $HOME/.npm-global

export GOENV_ROOT="$HOME/.goenv"
export GOPATH="$HOME/go"

export BAT_THEME="Monokai Extended Bright"

# if (( ! $PATH[(I)/usr/local/bin] )) &>/dev/null; then
#     export PATH=""
# fi

# Path should be set before fnm
export PATH="/usr/local/opt/llvm/bin:/usr/local/opt/whois/bin:/usr/local/opt/curl/bin:$HOME/.yarn/bin:$NPM_CONFIG_PREFIX/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$GOENV_ROOT/bin:$GOENV_ROOT/shims:/usr/local/opt/openjdk/bin:/usr/local/opt/openjdk@8/bin:$PATH:$GOPATH/bin"

# fnm
if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

if (( ! $PATH[(I)${__SUKKA_HOMEBREW_ZSH_COMPLETION}] && $+commands[brew] )) &>/dev/null; then
    FPATH=${__SUKKA_HOMWBREW__PREFIX}/share/zsh/site-functions:$FPATH
fi

# Lazyload Function

## Setup a mock function for lazyload
## Usage:
## 1. Define function "_sukka_lazyload_command_[command name]" that will init the command
## 2. sukka_lazyload_add_command [command name]
sukka_lazyload_add_command() {
    eval "$1() { \
        unfunction $1; \
        _sukka_lazyload_command_$1; \
        $1 \$@; \
    }"
}
## Setup autocompletion for lazyload
## Usage:
## 1. Define function "_sukka_lazyload_completion_[command name]" that will init the autocompletion
## 2. sukka_lazyload_add_comp [command name]
sukka_lazyload_add_completion() {
    local comp_name="_sukka_lazyload__compfunc_$1"
    eval "${comp_name}() { \
        compdef -d $1; \
        _sukka_lazyload_completion_$1; \
    }"
    compdef $comp_name $1
}

alias rezsh="omz reload"
if (( $+commands[code] )); then
    alias zshconfig="code $HOME/.zshrc"
elif (( $+commands[we] )); then
    alias zshconfig="we $HOME/.zshrc"
else
    alias zshconfig="nano $HOME/.zshrc"
fi


alias rmrf="rm -rf"
alias gitcm="git commit -m"
alias gitp="git push"
alias gita="git add -a"
alias gitall="git add ."
alias lg="lazygit"
# Git Undo
alias git-undo="git reset --soft HEAD^"

# Git Delete Local Merged
git-delete-local-merged() {
    red=$(tput setaf 1)
    blue=$(tput setaf 4)
    green=$(tput setaf 2)
    reset=$(tput sgr0)

    branches=($(git branch --merged master | grep -v "\*\|master\|unstable\|develop"))

    (( ! $#branches )) && printf "${green}\nNo merged branches to delete!${reset}\n"

    command="git branch -d $branches"

    echo ""
    printf "%s" "$branches"
    echo ""

    printf "\n${blue}Delete merged branches locally? Press [Enter] to continue...${reset}"
    read _

    echo ""
    echo "Safely deleting merged local branches..."

    for branch ($branches); do
        git branch -d $branch
    done

    echo "${green}Done!${reset}"
}

alias ping="nali-ping"
alias dig="nali-dig"
alias traceroute="nali-traceroute"
alias tracepath="nali-tracepath"
alias nslookup="nali-nslookup"

# Enable sudo in aliased
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

# Avoid stupidity with trash-cli:
# https://github.com/sindresorhus/trash-cli
# or use default rm -i
if (( $+commands[trash] )); then
  alias rm='trash'
else
  alias rm='rm -i'
fi

alias q="cd $HOME && clear"

alias digshort="dig @1.0.0.1 +short "

# Kills all docker containers running
docker-kill-all() {
    docker kill $(docker ps -aq)
}

cfdns="@1.0.0.1 +tcp"

alias restart_bluetooth="sudo pkill bluetoothd && sudo launchctl start com.apple.bluetoothd"

hash -d desktop="$HOME/Desktop"
hash -d music="$HOME/Music"
hash -d pictures="$HOME/Pictures"
hash -d picture="$HOME/Pictures"
hash -d downloads="$HOME/Downloads"
hash -d download="$HOME/Downloads"
hash -d documents="$HOME/Documents"
hash -d document="$HOME/Documents"
hash -d dropbox="$HOME/Dropbox"
hash -d services="$HOME/Services"
hash -d projects="$HOME/Project"
hash -d project="$HOME/Project"
hash -d work="$HOME/Work"
hash -d works="$HOME/Works"
hash -d tools="$HOME/Tools"
hash -d tool="$HOME/Tools"
hash -d applications="/Applications"
hash -d application="/Applications"
hash -d surge="$HOME/Library/Application Support/Surge/Profiles"
hash -d smartdns="$HOME/.config/smartdns"

alias finder_show="defaults write com.apple.finder AppleShowAllFiles YES"
alias finder_hide="defaults write com.apple.finder AppleShowAllFiles NO"
clear_finder_icon_cache() {
    green=$(tput setaf 2)
    reset=$(tput sgr0)
    printf "${green}%s${reset}\n" '- Cleaning "/Library/Caches/com.apple.iconservices.store" folder ...'
    sudo rm -rfv /Library/Caches/com.apple.iconservices.store
    printf "${green}%s${reset}\n" '- Cleaning "com.apple.dock.iconcache" and "com.apple.dock.iconcache" files ...'
    sudo find /private/var/folders/ \( -name com.apple.dock.iconcache -or -name com.apple.iconservices \) -exec rm -rfv {} \;
    sleep 1
    sudo touch /Applications/*
    printf "${green}%s${reset}\n" '- Restarting Dock & Finder ...'
    killall Dock
    killall Finder
    sleep 2
    printf "${green}%s${reset}\n" '- Done!'
}

clear_dns_cache() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    sudo killall mDNSResponderHelper
}
alias flushdns="clear_dns_cache"

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

    # git config --global alias.lg "log --graph --abbrev-commit --decorate --all --format=format:\"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)\""
    git config --global user.name "${username}"
    git config --global user.email "${email}"
}

brew-fix() {
    sudo chown -R $(whoami) /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
    chmod u+w /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
}

# Kills a process running on a specified tcp port
killport() {
  echo "Killing process on port: $1"
  fuser -n tcp -k $1;
}

# MVP
# Move and make parent directories
mvp() {
    source="$1"
    target="$2"
    target_dir=${target:h}
    mkdir --parents $target_dir; mv $source $target
}

find_folder_by_name() {
    local dir="$1"
    local name="$2"
    if (( $+commands[fd] )) &>/dev/null; then
        fd --color "never" -H -g --type d $name $dir
    else
        find $dir -type d -name $name
    fi
}

extract() {
    if [[ -f $1 ]]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

gitgc() {
    red=$(tput setaf 1)
    reset=$(tput sgr0)

    (
        cd $HOME/project
        find_folder_by_name "$HOME/project" ".git" | while read LINE; do
            echo "$red$LINE$reset"
            cd ${LINE:h}
            git gc
        done
    ) && echo "${red}Done!${reset}"
}

# override "omz update"

update_ohmyzsh_custom_plugins() {
    red=$(tput setaf 1)
    blue=$(tput setaf 4)
    green=$(tput setaf 2)
    reset=$(tput sgr0)

    echo ""
    printf "${blue}%s${reset}\n" "Upgrading custom plugins"

    find_folder_by_name "${ZSH_CUSTOM:-$ZSH/custom}" ".git" | while read LINE; do
        p=${LINE:h}
        pushd -q "${p}"

        if git pull --rebase; then
            printf "${green}%s${reset}\n" "${p:t} has been updated and/or is at the current version."
        else
            printf "${red}%s${reset}\n" "There was an error updating ${p:t}. Try again later?"
        fi
        popd -q
    done
}

eval "__sukka_original_$(which omz)"
unfunction omz

omz() {
    if [[ $1 == update ]]; then
        __sukka_original_omz update
        update_ohmyzsh_custom_plugins
    else
        __sukka_original_omz $@
    fi
}

# Load zsh-async worker
# source ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-async/async.zsh
# async_init

## Lazyload thefuck
if (( $+commands[thefuck] )) &>/dev/null; then
    _sukka_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    sukka_lazyload_add_command fuck
fi

## Lazyload pyenv
if (( $+commands[pyenv] )) &>/dev/null; then
    _sukka_lazyload_command_pyenv() {
        export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}" # pyenv init --path
        eval "$(command pyenv init -)"
    }
    sukka_lazyload_add_command pyenv

    _sukka_lazyload_completion_pyenv() {
        source "${__SUKKA_HOMEBREW_PYENV_PREFIX}/completions/pyenv.zsh"
    }
    sukka_lazyload_add_completion pyenv

    export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
fi

# hexo completion
if (( $+commands[hexo] )) &>/dev/null; then
    _hexo_completion() {
        compls=$(hexo --console-list)
        completions=(${=compls})
        compadd -- $completions
    }

    compdef _hexo_completion hexo
fi

# gulp completion
if (( $+commands[gulp] )) &>/dev/null; then
    _gulp_completion() {
        # Grab tasks
        compls=$(gulp --tasks-simple)
        completions=(${=compls})
        compadd -- $completions
    }

    compdef _gulp_completion gulp
fi

# pnpm
# pnpm completion
if (( $+commands[pnpm] )) &>/dev/null; then
    _pnpm_completion() {
        local reply
        local si=$IFS

        IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" pnpm completion -- "${words[@]}"))
        IFS=$si

        if [ "$reply" = "__tabtab_complete_files__" ]; then
          _files
        else
          _describe 'values' reply
        fi
    }
    compdef _pnpm_completion pnpm
fi
# pnpm end

# npm completion
if (( $+commands[npm] )) &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
fi

# fzf
if (( $+commands[fzf] )) &>/dev/null; then
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# goenv
if (( $+commands[goenv] )) &>/dev/null; then
    _sukka_lazyload_command_goenv() {
        eval "$(goenv init -)"
    }

    _sukka_lazyload_completion_goenv() {
        source "$GOENV_ROOT/completions/goenv.zsh"
    }

    sukka_lazyload_add_command goenv
    sukka_lazyload_add_completion goenv
fi

# conda
if (( $+commands[conda] )) &>/dev/null; then
  # lazyload conda
  __sukka_lazy_conda_aliases=('python' 'conda' 'pip' 'pip3' 'python3')
  for lazy_conda_alias in $__sukka_lazy_conda_aliases
  do
    alias $lazy_conda_alias="__sukka_load_conda && $lazy_conda_alias"
  done

  __sukka_load_conda() {
    for lazy_conda_alias in $__sukka_lazy_conda_aliases
    do
        unalias $lazy_conda_alias
    done
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/usr/local/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    # export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize

    unfunction __sukka_load_conda
  }
fi

# github copilot cli
if (( $+commands[github-copilot-cli] )) &>/dev/null; then
  # eval "$(github-copilot-cli alias -- "$0")"
fi

# zsh-osx-autoproxy (self use)
zsh-osx-autoproxy() {
    emulate -L zsh -o extended_glob
    # export https_proxy=http://127.0.0.1:6152
    # export http_proxy=http://127.0.0.1:6152
    # export all_proxy=socks5://127.0.0.1:6153

    # Cache the output of scutil --proxy
    local scutil_output=$(scutil --proxy)
    local -A info=(${=${(M)${(f)scutil_output}:#[A-Za-z ]# : [^ ]#}/:})

    local proxy_enabled=0

    if (( $info[HTTPEnable] )); then
        export http_proxy=http://$info[HTTPProxy]:$info[HTTPPort]
        export HTTP_PROXY=http://$info[HTTPProxy]:$info[HTTPPort]
        proxy_enabled=1
    fi
    if (( $info[HTTPSEnable] )); then
        export https_proxy=http://$info[HTTPSProxy]:$info[HTTPSPort]
        export HTTPS_PROXY=http://$info[HTTPSProxy]:$info[HTTPSPort]
        proxy_enabled=1
    fi
    if (( $info[FTPSEnable] )); then
        export ftp_proxy=http://$info[SOCKSProxy]:$info[SOCKSPort]
        export FTP_PROXY=http://$info[SOCKSProxy]:$info[SOCKSPort]
        proxy_enabled=1
    fi
    if (( $info[SOCKSEnable] )); then
        export all_proxy=socks5://$info[SOCKSProxy]:$info[SOCKSPort]
        export ALL_PROXY=socks5://$info[SOCKSProxy]:$info[SOCKSPort]
        proxy_enabled=1
    elif (( $info[HTTPEnable] )); then
        export all_proxy=http://$info[HTTPProxy]:$info[HTTPPort]
        export ALL_PROXY=http://$info[HTTPProxy]:$info[HTTPPort]
        proxy_enabled=1
    fi

    if (( $proxy_enabled )); then
        export NO_PROXY="127.0.0.0/8, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, 100.64.0.0/10, 162.14.0.0/16, localhost, *.local"
        export no_proxy="127.0.0.0/8, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, 100.64.0.0/10, 162.14.0.0/16, localhost, *.local"
    fi
}

noproxy() {
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    unset all_proxy
    unset ALL_PROXY
    unset ftp_proxy
    unset FTP_PROXY
}

zsh-osx-autoproxy
alias proxy="zsh-osx-autoproxy"

# Add OSX-like shadow to image
# USAGE: osx-shadow [--rm|-r] <original.png> [result.png]
osx-shadow() {
    # Help message
    function help {
        echo "Wrong number of arguments have been entered."
        echo "USAGE: osx-shadow [--rm|-r] <original.png> [result.png]"
    }

    if [[ $1 == --rm || $1 == -r ]]; then
        # Remove shadow
        case $# in
            3) # osx-shadow --rm|-r src.png dist.png
                convert $2 -crop +50+34 -crop -50-66 $3
                ;;
            2) # osx-shadow --rm|-r src.png
                convert $2 -crop +50+34 -crop -50-66 ${2%.*}-croped.png
                ;;
            *)
                help
                ;;
        esac
    else
        # Add shadow
        case $# in
            2) # osx-shadow src.png dist.png
                convert $1 \( +clone -background gray -shadow 100x40+0+16 \) +swap -background none -layers merge +repage $2
                ;;
            1) # osx-shadow src.png
                convert $1 \( +clone -background gray -shadow 100x40+0+16 \) +swap -background none -layers merge +repage ${1%.*}-shadow.png
                ;;
            *)
                help
                ;;
        esac
    fi
}

wg_ip="162.159.192.1"

sukka_local_ip() {
    echo $(ifconfig | awk '/inet /&&!/inet 127.0.0.1/&&!/inet 198.1/{print $2;exit}')
}

mtu() {
    [ -z $1 ] && echo "[MTU] Specifying host is a must" && return

    echo "[MTU] Getting the best MTU value for $1..."
    # lan_ip=$(ipconfig getifaddr en0)
    # lan_ip=$(osascript -e "IPv4 address of (system info)")
    lan_ip=$(sukka_local_ip)
    echo "[MTU] Source IP ${lan_ip}..."

    mtu_result=1500

    "ping" -c1 -W1 -D -s $((mtu_result - 28)) "$1" -S ${lan_ip} >/dev/null 2>&1
    until [[ $? = 0 || ${mtu_result} -le 1000 ]]; do
      mtu_result=$(( ${mtu_result} - 32))
      echo "[MTU] Ping ${mtu_result}"
      "ping" -c1 -W1 -D -s $((mtu_result - 28)) "$1" -S ${lan_ip} >/dev/null 2>&1
    done

    if [[ "${mtu_result}" -eq 1500 ]]; then
      # do nothing
    elif [[ "${mtu_result}" -le 1000 ]]; then
      mtu_result=1000
    else
      for (( i=0; i<32; i++ )); do
        (( mtu_result++ ))
        echo "[MTU] Ping ${mtu_result}"
        ( "ping" -c1 -W1 -D -s $((mtu_result - 28)) "$1" -S ${lan_ip} >/dev/null 2>&1 ) || break
      done
      (( mtu_result-- ))
    fi

    echo "[MTU] MTU: ${mtu_result}. WireGuard MTU: $(( mtu_result - 80 ))"
}

mtrskk() {
    "sudo" mtr -b -z -a $(sukka_local_ip) $@ | nali
}

# Add npm package manager prompt to powerlevel10k
prompt_sukka_npm_type() {
    if (( $+commands[node] || $+commands[yarn] || $+commands[npm] || $+commands[pnpm] )) &>/dev/null; then
        _p9k_upglob yarn.lock
        (( $? == 1 )) && {
            p10k segment -s "YARN" -f blue -t "yarn"
            return
        }
        _p9k_upglob pnpm-lock.yaml
        (( $? == 1 )) && {
            p10k segment -s "PNPM" -f yellow -t "pnpm"
            return
        }
        _p9k_upglob package-lock.json
        (( $? == 1 )) && {
            p10k segment -s "NPM" -f red -t "npm"
            return
        }
        _p9k_upglob package.json
        (( $? == 1 )) && {
            p10k segment -s "NPM" -f red -t "npm"
            return
        }
    fi
}

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
# Enable completion in zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

if (( $SUKKA_ENABLE_PERFORMANCE_PROFILING )); then
    unsetopt XTRACE
    exec 2>&3 3>&-

    parse_zsh_profiling() {
        typeset -a lines
        typeset -i prev_time=0
        typeset prev_command

        while read line; do
            if [[ $line =~ '^.*\+([0-9]{10})\.([0-9]{6})[0-9]* (.+)' ]]; then
                integer this_time=$match[1]$match[2]

                if [[ $prev_time -gt 0 ]]; then
                    time_difference=$(( $this_time - $prev_time ))
                    lines+="$time_difference $prev_command"
                fi

                prev_time=$this_time

                local this_command=$match[3]
                if [[ ${#this_command} -le 80 ]]; then
                    prev_command=$this_command
                else
                    prev_command="${this_command:0:77}..."
                fi
            fi
        done < ${1:-/dev/stdin}

        print -l ${(@On)lines}
    }

    zprof() {
        unfunction zprof

        parse_zsh_profiling $__sukka_zsh_profiling_logfile | head -n 50

        echo ""
        echo "========================================"
        echo ""

        zprof $@
    }
fi
