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
    rm -rf $HOME/_zsh_profile_output*
    zmodload zsh/zprof

    zmodload zsh/datetime

    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '
    __sukka_zsh_profiling_logfile=$(mktemp $HOME/_zsh_profile_output.XXXXXX)
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

# https://github.com/agkozak/zsh-z#case-sensitivity
ZSHZ_CASE=smart

# Cache Freq Use Variables
## Result of uname -sm
__SUKKA_UNAME_SM=$(uname -sm)
## Is currently on macOS
__SUKKA_IS_DARWIN=$OSTYPE[(I)darwin]
__SUKKA_IS_LINUX=$OSTYPE[(I)linux-gnu]
## Is currently on macOS M chip
local __sukka_darwin_64_str="Darwin arm64"
__SUKKA_IS_DARWIN_ARM64=$__SUKKA_UNAME_SM[(I)$__sukka_darwin_64_str]
## Homebrew prefix
(( $__SUKKA_IS_DARWIN_ARM64 )) && __SUKKA_HOMEBREW__PREFIX="/opt/homebrew" || __SUKKA_HOMEBREW__PREFIX="/usr/local"
## pyenv prefix
__SUKKA_HOMEBREW_PYENV_PREFIX="${__SUKKA_HOMEBREW__PREFIX}/opt/pyenv"
## Box Name used for my zsh-theme
# __SUKKA_BOX_NAME=${HOST/.local/}
# Homebrew zsh completion path
__SUKKA_HOMEBREW_ZSH_COMPLETION="${__SUKKA_HOMEBREW__PREFIX}/share/zsh/site-functions"
# zsh-completion fpath
# git clone https://github.com/zsh-users/zsh-completions $ZSH/custom/plugins/zsh-completions/
__SUKKA_ZSH_COMPLETION_SRC="${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src"

# This speed up zsh-autosuggetions by a lot
export ZSH_AUTOSUGGEST_USE_ASYNC="true"

# Enable Concurrent download for Homebrew -- https://github.com/Homebrew/brew/issues/18278
export HOMEBREW_DOWNLOAD_CONCURRENCY=36
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS="true"

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
    # fast-syntax-highlighting
    F-Sy-H
    zsh-gitcd
    # zsh-completion will be added to FPATH directly
    # zsh-completions
    zsh-z
    # zsh-interactive-cd
    fzf-tab
    zsh-fnm
    zsh-osx-autoproxy
)

typeset -U path
typeset -U fpath

# ZSH completions, needs to be added before oh-my-zsh
## For homebrew, is must be added before oh-my-zsh is called.
## https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
## https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/github/README.md#homebrew-installation-note
## Add a check avoiding duplicated fpath
if [[ -d ${__SUKKA_HOMEBREW_ZSH_COMPLETION} ]] && (( ! $FPATH[(I)${__SUKKA_HOMEBREW_ZSH_COMPLETION}] )); then
    FPATH=${__SUKKA_HOMEBREW_ZSH_COMPLETION}:$FPATH
fi
## https://github.com/zsh-users/zsh-completions
if [[ -d ${__SUKKA_ZSH_COMPLETION_SRC} ]] && (( ! $FPATH[(I)${__SUKKA_ZSH_COMPLETION_SRC}] )); then
    FPATH="${__SUKKA_ZSH_COMPLETION_SRC}:$FPATH"
fi

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
elif (( $+commands[micro] )); then
    export EDITOR='micro'
else
    export EDITOR='nano'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Node.js
# enable compile cache globally
# export NODE_COMPILE_CACHE=~/.cache/nodejs-compile-cache/v1

# pnpm add -g <package-name> fails with corepack · Issue #434 · nodejs/corepack
if (( $+XDG_DATA_HOME )) then
  # XDG_HOME is set
  export PNPM_HOME="$XDG_DATA_HOME/pnpm/store"
elif (( $__SUKKA_IS_LINUX )); then
  export PNPM_HOME="$HOME/.local/share/pnpm"
elif (( $__SUKKA_IS_DARWIN )); then
  export PNPM_HOME="$HOME/Library/pnpm"
elif (( $OSTYPE[(I)cygwin] || $OSTYPE[(I)win32] || $OSTYPE[(I)msys] )); then
  export PNPM_HOME="$HOME/AppData/Local/pnpm/store"
elif (( $OSTYPE[(I)freebsd] )); then
  export PNPM_HOME="$HOME/.pnpm-global"
fi

export GOPATH="$HOME/go"

export BAT_THEME="Monokai Extended Bright"

# PATH should be set before fnm (fnm prepend path automatically)
# append low priority path
export PATH="$PATH:$HOME/.antigravity/antigravity/bin"
# prepend /usr/local
# avoid duplicated /usr/local/bin and /usr/local/sbin in PATH
if (( ! $PATH[(I)/usr/local/sbin] )); then
    export PATH="/usr/local/sbin:$PATH"
fi
if (( ! $PATH[(I)/usr/local/bin] )); then
    export PATH="/usr/local/bin:$PATH"
fi
# ~/bin and ~/.local/bin
export PATH="${HOME}/.local/bin:${HOME}/bin:$PATH"
# homebrew
export PATH="${__SUKKA_HOMEBREW__PREFIX}/bin:${__SUKKA_HOMEBREW__PREFIX}/sbin:$PATH"
# prefer homebrew version over macOS built-in util
export PATH="${__SUKKA_HOMEBREW__PREFIX}/opt/whois/bin:$PATH"
export PATH="${__SUKKA_HOMEBREW__PREFIX}/opt/curl/bin:$PATH"
# go
export PATH="$GOPATH/bin:$PATH"
# rust
export PATH="${HOME}/.cargo/bin:$PATH"

# fnm
if (( $+commands[fnm] )); then
  # fnm is installed through package manager
  eval "$(fnm env --use-on-cd --resolve-engines --version-file-strategy=recursive --shell zsh)"
elif (( $__SUKKA_IS_LINUX )); then
  FNM_PATH="${HOME}/.local/share/fnm"
  if [[ -d "$FNM_PATH" ]]; then
    # fnm is installed through the shell script
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --use-on-cd --resolve-engines --version-file-strategy=recursive --shell zsh)"
  fi
fi

# After ensure fnm is initialized, we initialize zsh-fnm plugin
zsh_fnm

# prepend pnpm path afterward fnm init, so that pnpm-globally-installed corepack override fnm-built-in corepack
# pnpm_home/bin (pnpm 11) in front of pnpm_home (pnpm 10)
export PATH="$PNPM_HOME/bin:$PNPM_HOME:$PATH"

# open-cli
# only on non-macOS + open-cli exists
if (( ! __SUKKA_IS_DARWIN && $+commands[open-cli] )); then
    alias open="open-cli"
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
alias tree="tree -aC"

alias taze="taze --concurrency 24"
alias ncdu="ncdu -t 8"

# VSCode built-in CLI binding is so fucking slow, and this alias is so fucking fast
function code() {
    # if first arg starts with "-", passthru all arguments to "command code"
    if [[ "$1" == "-"* ]]; then
        command code "$@"
    else
      # passes the rest of args (if any) to --args command of "open"
      open $1 -a 'Visual Studio Code' --args "${(@)argv[2,-1]}" --new-window
    fi
}

# Git Delete Local Merged
# git-delete-local-merged() {
#     red=$(tput setaf 1)
#     blue=$(tput setaf 4)
#     green=$(tput setaf 2)
#     reset=$(tput sgr0)
#
#     branches=($(git branch --merged master | grep -v "\*\|master\|unstable\|develop"))
#
#     (( ! $#branches )) && printf "${green}\nNo merged branches to delete!${reset}\n"
#
#     command="git branch -d $branches"
#
#     echo ""
#     printf "%s" "$branches"
#     echo ""
#
#     printf "\n${blue}Delete merged branches locally? Press [Enter] to continue...${reset}"
#     read _
#
#     echo ""
#     echo "Safely deleting merged local branches..."
#
#     for branch ($branches); do
#         git branch -d $branch
#     done
#
#     echo "${green}Done!${reset}"
# }

# homebrew
# brew why
function brew() {
    if [[ $1 == "why" ]]; then
        command brew uses --installed $2
    else
        command brew "$@"
    fi
}

alias ping="nali-ping"
alias dig="nali-dig"
alias traceroute="nali-traceroute"
alias tracepath="nali-tracepath"
alias nslookup="nali-nslookup"

# Enable sudo in aliased
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

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
    git --git-dir="$HOME/ci_edit/.git" --work-tree="$HOME/ci_edit" pull --rebase && sudo "$HOME/ci_edit/install.sh"
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
        fd --color=never -H -I -g --type d $name $dir
    else
        find $dir -type d -name $name
    fi
}

find_folder_by_child_item() {
    local dir="$1"
    local child="$2"

    if (( $+commands[fd] )) &>/dev/null; then
        fd "$child" "$dir" --type f --exec dirname {}
    else
        find "$dir" -type f -name "$child" -exec dirname {}
    fi
}

extract() {
    if [[ -f $1 ]]; then
        case $1 in
        *.tar.bz2) tar vxjf $1 ;;
        *.tar.gz) tar vxzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar vxf $1 ;;
        *.tbz2) tar vxjf $1 ;;
        *.tgz) tar vxzf $1 ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function git_commit_date_now() {
    # In the git repo, this command will change the date of the latest commit to now
    if [[ -d .git ]]; then
        git commit --amend --no-edit --date "$(date +%Y-%m-%dT%H:%M:%S%z)"
    else
        echo "Not in a git repository" && return 1
    fi
}

sukka_run_git_maintainance_in_folder() {
    blue=$(tput setaf 4)
    reset=$(tput sgr0)

    find_folder_by_name $1 ".git" | while read LINE; do
        echo "$blue$LINE$reset"
        git --git-dir="${LINE}" maintenance run
    done
}

gitgc() {
    green=$(tput setaf 2)
    reset=$(tput sgr0)
    (
        sukka_run_git_maintainance_in_folder "$__SUKKA_HOMEBREW__PREFIX"
        sukka_run_git_maintainance_in_folder "$HOME/project"
        sukka_run_git_maintainance_in_folder "$HOME/works"
        sukka_run_git_maintainance_in_folder "${ZSH_CUSTOM:-$ZSH/custom}/plugins"
        sukka_run_git_maintainance_in_folder "${__SUKKA_HOMEBREW__PREFIX}/Library/Taps"
    ) && echo "${green}Done!${reset}"
}

sukka_run_pnpm_prune_in_folder() {
    blue=$(tput setaf 4)
    reset=$(tput sgr0)

    find_folder_by_child_item $1 "pnpm-lock.yaml" | while read LINE; do
        echo "$blue$LINE$reset"
        (
           cd "$LINE" && pnpm prune
        )
    done
    find_folder_by_child_item $1 "package-lock.json" | while read LINE; do
        echo "$blue$LINE$reset"
        (
           cd "$LINE" && npm dedupe
        )
    done
}

pnpmgc() {
    green=$(tput setaf 2)
    reset=$(tput sgr0)
    (
        sukka_run_pnpm_prune_in_folder "$HOME/project"
        sukka_run_pnpm_prune_in_folder "$HOME/works"
    )
    pnpm store prune
    echo "${green}Done!${reset}"
}

# Override `omz` to add `omz plugin update` extension while preserving original behavior
# - Saves original `omz` function (if present) as `__omz_original`
# - When `omz plugin update` is called, runs `update_ohmyzsh_custom_plugins` first,
#   then delegates to the original implementation so nothing else breaks.
if (( $+functions[omz] )); then
  eval "${$(typeset -f omz)/omz/__omz_original}" 2>/dev/null || true
  unfunction omz
fi

_update_ohmyzsh_custom_plugins() {
    red=$(tput setaf 1)
    blue=$(tput setaf 4)
    green=$(tput setaf 2)
    reset=$(tput sgr0)

    echo ""
    printf "${blue}%s${reset}\n" "Upgrading custom plugins"

    local p=""

    find_folder_by_name "${ZSH_CUSTOM:-$ZSH/custom}" ".git" | while read LINE; do
        p=${LINE:h}

        printf "${blue}%s${reset}\n" "${p:t}"

        if git --git-dir="${LINE}" --work-tree="${p}" pull --rebase; then
            git --git-dir="${LINE}" maintenance run
            printf "${green}%s${reset}\n" "${p:t} has been updated and/or is at the current version."
        else
          # If error is due to unstaged changes, reset and retry
          if git --git-dir="${LINE}" --work-tree="${p}" status --porcelain | grep -q '^ '; then
            printf "${red}%s${reset}\n" "Unstaged changes detected in ${p:t}. Resetting and retrying..."
            git --git-dir="${LINE}" --work-tree="${p}" reset --hard
            if git --git-dir="${LINE}" --work-tree="${p}" pull --rebase; then
              git --git-dir="${LINE}" maintenance run
              printf "${green}%s${reset}\n" "${p:t} has been updated after reset."
            else
              printf "${red}%s${reset}\n" "Update failed again for ${p:t}. Manual intervention may be required."
            fi
          else
            printf "${red}%s${reset}\n" "There was an error updating ${p:t}. Try again later?"
          fi
        fi
    done
}

omz() {
  if [[ "$1" == "plugin" && "$2" == "update" ]]; then
    # First, update custom plugins (defined by update_ohmyzsh_custom_plugins)
    _update_ohmyzsh_custom_plugins
  else
    # For all other subcommands, delegate to original implementation (function or command)
    __omz_original "$@"
  fi
}

## Lazyload thefuck
if (( $+commands[thefuck] )) &>/dev/null; then
    _sukka_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    sukka_lazyload_add_command fuck
fi

# ## Lazyload pyenv
# if (( $+commands[pyenv] )) &>/dev/null; then
#     _sukka_lazyload_command_pyenv() {
#         export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}" # pyenv init --path
#         eval "$(command pyenv init -)"
#     }
#     sukka_lazyload_add_command pyenv
#
#     _sukka_lazyload_completion_pyenv() {
#         source "${__SUKKA_HOMEBREW_PYENV_PREFIX}/completions/pyenv.zsh"
#     }
#     sukka_lazyload_add_completion pyenv
#
#     export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
# fi

# hexo completion
# if (( $+commands[hexo] )) &>/dev/null; then
#     _hexo_completion() {
#         compls=$(hexo --console-list)
#         completions=(${=compls})
#         compadd -- $completions
#     }
#     compdef _hexo_completion hexo
# fi

# pnpm
if (( $+commands[pnpm] )) &>/dev/null; then
  _pnpm_completion () {
    local reply
    local si=$IFS

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}"))
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
    compadd -- $(COMP_CWORD=$((CURRENT-1)) COMP_LINE=$BUFFER COMP_POINT=0 npm completion -- "${words[@]}" 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
fi

# bun completions
if (( $+commands[bun] )) &>/dev/null; then
  _sukka_lazyload_completion_bun() {
    [[ -f "${HOME}/.bun/_bun" ]] && source "${HOME}/.bun/_bun"
  }
  sukka_lazyload_add_completion bun
fi

# fzf
if (( $+commands[fzf] )) &>/dev/null; then
  [[ $- == *i* ]] && source "${__SUKKA_HOMEBREW__PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null
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
    if (( ! $? )); then
        eval "$__conda_setup"
    else
        if [[ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]]; then
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

# mise - when installed via homebrew it exists under homebrew bin
export MISE_EXPERIMENTAL=true
export MISE_ENV=development
export MISE_NPM_PACKAGE_MANAGER=pnpm

if (( $+commands[mise] )) &>/dev/null; then
    _sukka_lazyload_command_mise() {
        eval "$($__SUKKA_HOMEBREW__PREFIX/bin/mise activate zsh)"
    }
    sukka_lazyload_add_command mise
fi

# mole - https://github.com/tw93/Mole/issues
if (( $+commands[mole] )) &>/dev/null; then
    _sukka_lazyload_completion_mole() {
        eval "$($__SUKKA_HOMEBREW__PREFIX/bin/mole completion zsh 2>/dev/null)"
    }

    sukka_lazyload_add_completion mole
fi

alias proxy="zsh-osx-autoproxy"
alias noproxy="proxy_off"

# Add OSX-like shadow to image
# USAGE: osx-shadow <original.png> [result.png]
osx-shadow() {
    if (( ! $+commands[magick] )); then
        echo "ImageMagick 'magick' command not found. Please install ImageMagick first."
        return 1
    fi

    # Help message
    function help {
        echo "Wrong number of arguments have been entered."
        echo "USAGE: osx-shadow <original.png> [result.png]"
    }

    # convert test.png \( +clone -background black -shadow 40x50+0+36 \) +swap -background transparent -layers merge +repage test-shadow.png

    # Add shadow
    case $# in
        2) # osx-shadow src.png dist.png
            magick $1 \( +clone -background black -shadow 70x40+0+16 \) +swap -background transparent -bordercolor none -layers merge -border 32 +repage $2
            ;;
        1) # osx-shadow src.png
            magick $1 \( +clone -background black -shadow 70x40+0+16 \) +swap -background transparent -bordercolor none -layers merge -border 32 +repage ${1%.*}-shadow.png
            ;;
        *)
            help
            ;;
    esac
}

warp_ip="162.159.192.1"

sukka_local_ip() {
    if (( $__SUKKA_IS_DARWIN )); then
        # Get the list of network services and their corresponding devices, remove extra characters
        # Use a while loop with read to iterate over each line
        local line device deviceinfo ip

        local match=", Device: "

        for line in ${${${(f)"$(networksetup -listnetworkserviceorder)"}##[[:space:]]#}%%[[:space:]]#}; do
            if (( $line[(I)$match] )); then
                device=${${line#*$match}:0:-1}
                deviceinfo=$(ifconfig $device 2>/dev/null)

                if (( ( $deviceinfo[(I)status: active] ) && ( ! $deviceinfo[(I)127.] ) && ( ! $deviceinfo[(I)198.] ) && ( $deviceinfo[(I)inet ] ) )); then
                    ip=$(ipconfig getifaddr $device 2>/dev/null)
                    if (( ${#ip} )); then
                        echo "$ip"
                        return 0
                    fi
                fi
            fi
        done
    else
        local ip=$(ip route show default | grep -Po '(?<=(src ))(\S+)')
        if (( $+ip )); then
            echo "$ip"
            return 0
        fi
    fi
    echo "256.256.256.256" # output invalid ip
    return 1
}

sukka_primary_interface() {
    if (( $__SUKKA_IS_DARWIN )); then
        local line
        local device
        local deviceinfo
        local ip
        local match=", Device: "

        for line in ${${${(f)"$(networksetup -listnetworkserviceorder)"}##[[:space:]]#}%%[[:space:]]#}; do
            if (( $line[(I)$match] )); then
                device=${${line#*$match}:0:-1}
                deviceinfo=$(ifconfig $device 2>/dev/null)

                if (( ( $deviceinfo[(I)status: active] ) && ( $deviceinfo[(I)inet ] ) )); then
                    echo "$device"
                    return 0
                fi
            fi
        done
    else
        # local route=$(ip route show default)
        local device=$(ip route show default | grep -Po '(?<=(dev ))(\S+)')
        if (( $+device )); then
            echo "$device"
            return 0
        fi
    fi

    return 1
}

mtu() {
    (( ! $+1 )) && echo "[MTU] Specifying host is a must" && return

    echo "[MTU] Getting the best MTU value for $1..."

    primary_interface=$(sukka_primary_interface)
    echo "[MTU] Primary interface: ${primary_interface}"

    local mtu_lo=1000 mtu_hi=16384 mtu_result

    while (( mtu_hi - mtu_lo > 1 )); do
      mtu_result=$(( (mtu_lo + mtu_hi) / 2 ))
      echo "[MTU] Ping ${mtu_result}"
      if command ping -c1 -W1 -D -s $((mtu_result - 28)) -b ${primary_interface} "$1" >/dev/null 2>&1; then
        mtu_lo=${mtu_result}
      else
        mtu_hi=${mtu_result}
      fi
    done

    mtu_result=${mtu_lo}

    echo "[MTU] MTU: ${mtu_result}. WireGuard MTU: $(( mtu_result - 80 ))"
}

mtrskk() {
    "sudo" mtr -b -z -e -m 63 -I $(sukka_primary_interface) $@ | nali
}

traceskk() {
    "sudo" "nexttrace" --always-rdns --dot-server dnssb --dev $(sukka_primary_interface) $@
}

tmpfile() {
  for filepath in "$@"
  do
    echo $(curl -F "reqtype=fileupload" --progress-bar -F "time=1h" -F "fileToUpload=@$filepath" https://litterbox.catbox.moe/resources/internals/api.php)
    # echo $(curl --progress-bar -F "file=@$filepath" https://tmpfiles.org/api/v1/upload) # server error when uploading some files
    # echo $(curl --progress-bar -F "file=@$filepath" https://temp.sh/upload)
  done
}
alias pastefile="tmpfile"

# Add npm package manager prompt to powerlevel10k
prompt_sukka_npm_type() {
    if (( $+commands[node] || $+commands[yarn] || $+commands[npm] || $+commands[pnpm] || $+commands[bun] )) &>/dev/null; then
        _p9k_upglob pnpm-lock.yaml
        (( $? == 1 )) && {
            p10k segment -s "PNPM" -f yellow -t "pnpm"
            return
        }
        _p9k_upglob yarn.lock
        (( $? == 1 )) && {
            p10k segment -s "YARN" -f blue -t "yarn"
            return
        }
        _p9k_upglob package-lock.json
        (( $? == 1 )) && {
            p10k segment -s "NPM" -f red -t "npm"
            return
        }
        _p9k_upglob bun.lockb
        (( $? == 1 )) && {
            p10k segment -s "BUN" -f white -t "bun"
            return
        }
        _p9k_upglob bun.lock
        (( $? == 1 )) && {
            p10k segment -s "BUN" -f white -t "bun"
            return
        }
        _p9k_upglob deno.lock
        (( $? == 1 )) && {
            p10k segment -s "DENO" -f white -t "deno"
            return
        }
        _p9k_upglob deno.json
        (( $? == 1 )) && {
            p10k segment -s "DENO" -f white -t "deno"
            return
        }
        _p9k_upglob package.json
        (( $? == 1 )) && {
            p10k segment -s "NPM" -f red -t "npm"
            return
        }
    fi
}
# Add my ip prompt to powerlevel10k
prompt_sukka_custom_ip() {
  local -i len=$#_p9k__prompt _p9k__has_upglob
  local ip='${_p9k__public_ip:-$_POWERLEVEL9K_PUBLIC_IP_NONE}'
  _p9k_prompt_segment "$0" "$_p9k_color1" "$_p9k_color2" PUBLIC_IP_ICON 1 $ip $ip
  (( _p9k__has_upglob )) || typeset -g "_p9k__segment_val_${_p9k__prompt_side}[_p9k__segment_index]"=$_p9k__prompt[len+1,-1]
}
_p9k_prompt_sukka_custom_ip_init() {
  typeset -g _p9k__=
  typeset -gF _p9k__public_ip_next_time=0
  _p9k__async_segments_compute+='_p9k_worker_invoke public_ip _p9k_prompt_sukka_custom_ip_compute'
}
_p9k_prompt_sukka_custom_ip_compute() {
  (( EPOCHREALTIME >= _p9k__public_ip_next_time )) || return
  _p9k_worker_async _p9k_prompt_sukka_custom_ip_async _p9k_prompt_sukka_custom_ip_sync
}
_p9k_prompt_sukka_custom_ip_async() {
  local ip
  local -F start=EPOCHREALTIME
  local -F next='start + 5'
  if (( $+commands[curl] )); then
    ip="$(curl --max-time 5 -w '\n' "https://ip.api.skk.moe/shell-prompt" 2>/dev/null)"
  fi
  if (( $+ip )); then
    next=$((start + 240))
  fi
  _p9k__public_ip_next_time=$next
  _p9k_print_params _p9k__public_ip_next_time
  [[ $_p9k__public_ip == $ip ]] && return
  _p9k__public_ip=$ip
  _p9k_print_params _p9k__public_ip
  echo -E - 'reset=1'
}
_p9k_prompt_sukka_custom_ip_sync() {
  eval $REPLY
  _p9k_worker_reply $REPLY
}

# Replace p10k built-in proxy prompt with mine, this time no print IP and port

typeset -g POWERLEVEL9K_SUKKA_PROXY_FOREGROUND=68
typeset -g POWERLEVEL9K_SUKKA_PROXY_VISUAL_IDENTIFIER_EXPANSION='proxy'

function prompt_sukka_proxy() {
  local -U p=(
    $all_proxy $http_proxy $https_proxy $ftp_proxy
    $ALL_PROXY $HTTP_PROXY $HTTPS_PROXY $FTP_PROXY)
  p=(${(@)${(@)${(@)p#*://}##*@}%%/*})
  (( $#p == 1 )) || p=("")
  _p9k_prompt_segment $0 $_p9k_color1 blue SUKKA_PROXY_ICON 0 '' ''
}

_p9k_prompt_sukka_proxy_init() {
  typeset -g "_p9k__segment_cond_${_p9k__prompt_side}[_p9k__segment_index]"='$all_proxy$http_proxy$https_proxy$ftp_proxy$ALL_PROXY$HTTP_PROXY$HTTPS_PROXY$FTP_PROXY'
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

function fixapp() {
  RED='\033[0;31m'
  GRN='\033[0;32m'
  BLU='\033[0;34m'
  NC='\033[0m'

  echo ""
  echo -e "---------------------------------------------------------------------"
  echo -e "应用打不开？GateKeeper 辅助工具，由 ${RED}Sukka${NC} 制作"
  echo ""
  echo -e "https://skk.moe | https://blog.skk.moe"
  echo -e "---------------------------------------------------------------------"
  echo -e "${BLU}1: 全局禁用 macOS 中的 GateKeeper${NC}"
  echo -e "${RED}非常不建议，会导致 macOS 暴露于风险之中 >> 仅供专业用户使用${NC}"
  echo ""
  echo -e "${BLU}2: 全局启用 macOS 中的 GateKeeper${NC}"
  echo -e "全局启用 GateKeeper，并撤销所有绕过、重置白名单"
  echo -e "${GRN}非常安全 >> 你可以用这个选项撤销对 GateKeeper 的所有改动${NC}"
  echo ""
  echo -e "${BLU}3: 允许某一个应用文件绕过 GateKeeper${NC}"
  echo -e "如果你不想全局禁用 GateKeeper 的话，可以为某一个应用添加白名单"
  echo -e "${GRN}相对安全 >> 推荐所有用户使用${NC}"
  echo ""
  echo -e "${BLU}4: 为某一个应用文件重新签名${NC}"
  echo -e "如果 macOS 提示应用损坏无法打开，先别急着禁用 SIP、可以试试这个选项"
  echo -e "---------------------------------------------------------------------"
  PS3="请输入你的选择 (1-5): "

  local options=(
    "全局禁用 macOS 中的 GateKeeper"
    "全局启用 macOS 中的 GateKeeper"
    "允许某一个应用绕过 GateKeeper"
    "为某一个应用文件重新签名"
    "退出"
  )

  select opt in "${options[@]}"; do
    case $opt in
    "全局禁用 macOS 中的 GateKeeper")
      echo ""
      echo -e "${RED}你选择了全局禁用 macOS 的 GateKeeper${NC}"
      echo ""
      echo -e "${RED}请输入你的登陆密码以继续${NC}"
      echo ""
      sudo spctl --master-disable
      break
      ;;
    "全局启用 macOS 中的 GateKeeper")
      echo ""
      echo -e "${GRN}你选择了启用 macOS 的 GateKeeper${NC}"
      echo ""
      echo -e "${RED}请输入你的登陆密码以继续${NC}"
      echo ""
      sudo spctl --master-enable
      break
      ;;
    "允许某一个应用绕过 GateKeeper")
      echo ""
      echo -e "${GRN}你选择了允许某一个应用绕过 GateKeeper${NC}"
      echo ""
      echo "请将需要绕过 GateKeeper 的 .app 文件 拖动到终端中"
      echo "当终端中显示 .app 文件的绝对路径后，按 Return (Enter) 继续"
      echo ""
      printf "文件路径："
      IFS= read -r FILEPATH
      echo ""
      echo -e "${RED}请输入你的登陆密码以继续${NC}"
      echo ""
      sudo xattr -rd com.apple.quarantine "$FILEPATH"
      break
      ;;
    "为某一个应用文件重新签名")
      echo ""
      echo -e "${BLU}你选择了为某个 .app 文件重新签名${NC}"
      echo ""
      if command -v codesign >/dev/null; then
        echo "请将需要重新签名的 .app 文件 拖动到终端中"
        echo "当终端中显示 .app 文件的绝对路径后，按 Return (Enter) 继续"
        echo ""
        printf "文件路径："
        IFS= read -r FILEPATH
        echo ""
        echo -e "${RED}请输入你的登陆密码以继续${NC}"
        echo ""
        sudo codesign --force --deep --sign - "$FILEPATH"
        echo ""
        echo -e "${BLU}如果你看到了 - replacing existing signature - 就说明签名成功${NC}"
        echo ""
        echo -e "${BLU}如果没有，说明你的 .app 文件可能已经损坏、或者 .app 文件的路径错误${NC}"
        echo ""
      else
        echo -e "${RED}你的 macOS 中没有安装 Xcode 命令行工具，无法使用签名功能！${NC}"
        echo -e "请在终端中执行 ${BLU}xcode-select --install${NC} 命令后再使用本工具！"
      fi

      break
      ;;
    "退出")
      echo "在看到 [Process completed] 后，就可以关闭终端窗口了"
      break
      ;;
    *)
      echo -e "${RED}你选的这个 ($REPLY) 是什么 xx 玩意儿？重新选一个！${NC}"
      ;;
    esac
  done
}

# Store commands in history only if successful
# CREDITS:
# https://gist.github.com/danydev/4ca4f5c523b19b17e9053dfa9feb246d
# https://scarff.id.au/blog/2019/zsh-history-conditional-on-command-success/

function __fd18et_prevent_write() {
  __fd18et_LASTHIST=$1
  return 2
}
function __fd18et_save_last_successed() {
  if [[ ($? == 0 || $? == 130) && -n $__fd18et_LASTHIST && -n $HISTFILE ]] ; then
    print -sr -- ${=${__fd18et_LASTHIST%%'\n'}}
  fi
}
add-zsh-hook zshaddhistory __fd18et_prevent_write
add-zsh-hook precmd __fd18et_save_last_successed
add-zsh-hook zshexit __fd18et_save_last_successed

bindkey '^[^M' self-insert-unmeta
