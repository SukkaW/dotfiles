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
export SUKKA_ENABLE_PERFORMANCE_PROFILING="false"

if [[ "${SUKKA_ENABLE_PERFORMANCE_PROFILING:-}" == "true" ]]; then
    zmodload zsh/zprof

    zmodload zsh/datetime

    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '
    rm -rf zsh_profile*
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
export UPDATE_ZSH_DAYS=4

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
ZSH_DISABLE_COMPFIX="true"

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
__SUKKA_ZSH_COMPLETION_SRC="$HOME/.oh-my-zsh/custom/plugins/zsh-completions/src"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
    # osx
    # openload
    zsh-autosuggestions
    # git
    # zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-gitcd
    # zsh-completion will be added to FPATH directly
    # zsh-completions
    zsh_reload
    zsh-z
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

# Set tj/n Path
export N_PREFIX="$HOME/.n"
export N_PRESERVE_NPM=1

# Set NPM Global Path
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
# Create .npm-global folder if not exists
[[ ! -d "$HOME/.npm-global" ]] && mkdir -p $HOME/.npm-global

export GOENV_ROOT="$HOME/.goenv"
export GOPATH="$HOME/go"

export PATH="/usr/local/opt/curl/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.yarn/bin:$NPM_CONFIG_PREFIX/bin:$N_PREFIX/bin:$HOME/bin:$GOENV_ROOT/bin:$GOENV_ROOT/shims:/usr/local/opt/openjdk/bin:$PATH:$GOPATH/bin"


export BAT_THEME="Monokai Extended Bright"
export HOMEBREW_NO_AUTO_UPDATE=1

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

alias rezsh="src"
alias zshconfig="code $HOME/.zshrc"
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

# Enable aliases to be sudo’ed
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
hash -d projects="$HOME/Projects"
hash -d project="$HOME/Projects"
hash -d applications="/Applications"
hash -d application="/Applications"

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

gitpullall() {
    red=$(tput setaf 1)
    reset=$(tput sgr0)

    (
        cd $HOME/project
        find $(pwd) -type d -name ".git" | while read LINE; do
            echo "$red$LINE$reset"
            cd ${LINE:h}
            git pull
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

    find "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}" -type d -name ".git" | while read LINE; do
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
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-async/async.zsh
async_init

## Lazyload thefuck
if (( $+commands[thefuck] )) &>/dev/null; then
    _sukka_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    sukka_lazyload_add_command fuck
fi

## Lazyload pyenv
if (( $+commands[pyenv] )) &>/dev/null; then
    export PATH="${PYENV_ROOT}/shims:${PATH}"
    export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"

    load_pyenv() {
        eval "$(command pyenv init -)"
        source "${__SUKKA_HOMEBREW_PYENV_PREFIX}/completions/pyenv.zsh"
    }

    async_start_worker pyenv_worker -n
    async_register_callback pyenv_worker load_pyenv
    async_job pyenv_worker sleep 0.1
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

# pnpm completion
if (( $+commands[pnpm] )) &>/dev/null; then
    _pnpm_completion() {
        local reply
        local si=$IFS

        IFS=$'\n'
        reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" pnpm completion -- "${words[@]}"))
        IFS=$si

        _describe 'values' reply
    }

    compdef _pnpm_completion pnpm
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

# zsh-osx-autoproxy (self use)
zsh-osx-autoproxy() {
    # Cache the output of scutil --proxy
    __ZSH_OSX_AUTOPROXY_SCUTIL_PROXY=$(scutil --proxy)

    # Pattern used to match the status
    __ZSH_OSX_AUTOPROXY_HTTP_PROXY_ENABLED_PATTERN="HTTPEnable : 1"
    __ZSH_OSX_AUTOPROXY_HTTPS_PROXY_ENABLED_PATTERN="HTTPSEnable : 1"
    __ZSH_OSX_AUTOPROXY_FTP_PROXY_ENABLED_PATTERN="FTPSEnable : 1"
    __ZSH_OSX_AUTOPROXY_SOCKS_PROXY_ENABLED_PATTERN="SOCKSEnable : 1"

    __ZSH_OSX_AUTOPROXY_HTTP_PROXY_ENABLED=$__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY[(I)$__ZSH_OSX_AUTOPROXY_HTTP_PROXY_ENABLED_PATTERN]
    __ZSH_OSX_AUTOPROXY_HTTPS_PROXY_ENABLED=$__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY[(I)$__ZSH_OSX_AUTOPROXY_HTTPS_PROXY_ENABLED_PATTERN]
    __ZSH_OSX_AUTOPROXY_FTP_PROXY_ENABLED=$__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY[(I)$__ZSH_OSX_AUTOPROXY_FTP_PROXY_ENABLED_PATTERN]
    __ZSH_OSX_AUTOPROXY_SOCKS_PROXY_ENABLED=$__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY[(I)$__ZSH_OSX_AUTOPROXY_SOCKS_PROXY_ENABLED_PATTERN]

    # http proxy
    if (( $__ZSH_OSX_AUTOPROXY_HTTP_PROXY_ENABLED )); then
        __ZSH_OSX_AUTOPROXY_HTTP_PROXY_SERVER=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*HTTPProxy : }[(f)1]}
        __ZSH_OSX_AUTOPROXY_HTTP_PROXY_PORT=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*HTTPPort : }[(f)1]}
        export http_proxy="http://${__ZSH_OSX_AUTOPROXY_HTTP_PROXY_SERVER}:${__ZSH_OSX_AUTOPROXY_HTTP_PROXY_PORT}"
        export HTTP_PROXY="${http_proxy}"
    fi
    # https_proxy
    if (( $__ZSH_OSX_AUTOPROXY_HTTPS_PROXY_ENABLED )); then
        __ZSH_OSX_AUTOPROXY_HTTPS_PROXY_SERVER=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*HTTPSProxy : }[(f)1]}
        __ZSH_OSX_AUTOPROXY_HTTPS_PROXY_PORT=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*HTTPSPort : }[(f)1]}
        export https_proxy="http://${__ZSH_OSX_AUTOPROXY_HTTPS_PROXY_SERVER}:${__ZSH_OSX_AUTOPROXY_HTTPS_PROXY_PORT}"
        export HTTPS_PROXY="${https_proxy}"
    fi
    # ftp_proxy
    if (( $__ZSH_OSX_AUTOPROXY_FTP_PROXY_ENABLED )); then
        __ZSH_OSX_AUTOPROXY_FTP_PROXY_SERVER=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*FTPProxy : }[(f)1]}
        __ZSH_OSX_AUTOPROXY_FTP_PROXY_PORT=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*FTPPort : }[(f)1]}
        export ftp_proxy="http://${__ZSH_OSX_AUTOPROXY_FTP_PROXY_SERVER}:${__ZSH_OSX_AUTOPROXY_FTP_PROXY_PORT}"
        export FTP_PROXY="${ftp_proxy}"
    fi
    # all_proxy
    if (( $__ZSH_OSX_AUTOPROXY_SOCKS_PROXY_ENABLED )); then
        __ZSH_OSX_AUTOPROXY_SOCKS_PROXY_SERVER=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*SOCKSProxy : }[(f)1]}
        __ZSH_OSX_AUTOPROXY_SOCKS_PROXY_PORT=${${__ZSH_OSX_AUTOPROXY_SCUTIL_PROXY#*SOCKSPort : }[(f)1]}
        export all_proxy="http://${__ZSH_OSX_AUTOPROXY_SOCKS_PROXY_SERVER}:${__ZSH_OSX_AUTOPROXY_SOCKS_PROXY_PORT}"
        export ALL_PROXY="${all_proxy}"
    elif (( $__ZSH_OSX_AUTOPROXY_HTTP_PROXY_ENABLED )); then
        export all_proxy="${http_proxy}"
        export ALL_PROXY="${all_proxy}"
    fi
}

async_register_callback background_worker zsh-osx-autoproxy
async_job background_worker sleep 0.1

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# This speed up zsh-autosuggetions by a lot
export ZSH_AUTOSUGGEST_USE_ASYNC='true'
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

if [[ "${SUKKA_ENABLE_PERFORMANCE_PROFILING:-}" == "true" ]]; then
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

        parse_zsh_profiling $__sukka_zsh_profiling_logfile | head -n 30

        echo ""
        echo "========================================"
        echo ""

        zprof $@
    }
fi
