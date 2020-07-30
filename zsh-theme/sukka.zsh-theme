# Copy and self modified from ys.zsh-theme, the one of default themes in master repository
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# 2018-12-7 - Sukka

# Machine name.
box_name() {
  if [[ -z ${__SUKKA_BOX_NAME} ]]; then
    __SUKKA_BOX_NAME=${HOST/.local/}
  fi

  echo ${__SUKKA_BOX_NAME}
}

# Directory info.rez
local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_PREFIX1="%{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%} "
YS_VCS_PROMPT_DIRTY="%{$fg[white]%}(%{$fg[red]%}x%{$fg[white]%})"
YS_VCS_PROMPT_CLEAN="%{$fg[white]%}(%{$fg[green]%}o%{$fg[white]%})"

# Git info.
local git_info='$(git_prompt_info)'
local git_last_commit='$(git log --pretty=format:"%h %s" -1 2> /dev/null)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info) '
ys_hg_prompt_info() {
  if (( $+commands[hg] )) &>/dev/null; then
    # make sure this is a hg dir
    if [[ -d '.hg' ]]; then
      echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
      echo -n $(hg branch 2>/dev/null)
      if [[ -n "$(hg status 2>/dev/null)" ]]; then
        echo -n "$YS_VCS_PROMPT_DIRTY"
      else
        echo -n "$YS_VCS_PROMPT_CLEAN"
      fi
      echo -n "$YS_VCS_PROMPT_SUFFIX"
    fi
  fi
}

# Node.js version
local node_version='$(node_version_prompt_info)'
node_version_prompt_info() {
  if (( $+commands[node] )) &>/dev/null; then
    echo -n "%{$fg[green]%}%B⬡%b %{$fg[green]%}$(node -v 2>&1)%{$reset_color%}"
  fi
}

# Exit Code
local exit_code="%(?,,%{$fg[red]%}c:%?%{$reset_color%})"

# Prompt format: \n # TIME USER at MACHINE in [DIRECTORY] on git:BRANCH STATE \n $
PROMPT="
%{$fg[blue]%}[20%D %*] \
%{$fg[green]%}%n %{$fg[white]%}@ %{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[blue]%}${current_dir}%{$reset_color%}\
${hg_info}${git_info}${git_last_commit} ${exit_code}
%{$fg[magenta]%}$ %{$reset_color%}"

RPROMPT="%{$(echotc UP 1)%} ${node_version}%{$(echotc DO 1)%}"
