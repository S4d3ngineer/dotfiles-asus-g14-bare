#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias pn='pnpm'
alias ls='eza'
alias v='nvim'
alias lv='NVIM_APPNAME=LazyVim nvim'
alias lg='lazygit'
alias yz='yazi'
alias shut='shutdown now'
alias susp='systemctl suspend'
# alias hiber='systemctl hibernate'
alias sshalive='ssh -v -o ServerAliveInterval=60'
alias config='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias nr='npm run'

# PS1='[\u@\h \W]\$ '

alias keycodes='xev | awk -F"[ )]+" "/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\\n\", \$5, \$8 }"'

export GTK_THEME=Adwaita-dark
export QT_QPA_PLATFORMTHEME=gtk3
export PREFER_DARK=1
export GTK_FORCE_DARK=1
export WEBKIT_DISABLE_COMPOSITING_MODE=1

export EDITOR='nvim'
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

eval $(keychain --eval --quiet github-civil slapab_gitlab_rndlab_online)

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# vvv nvm automatic version detection vvv

rnv() {
  nvm_path="$(nvm_find_up .nvmrc | command tr -d '\n')"

  if [[ ! $nvm_path = *[^[:space:]]* ]]; then

    declare default_version
    default_version="$(nvm version default)"

    # If there is no default version, set it to `node`
    # This will use the latest version on your machine
    if [ $default_version = 'N/A' ]; then
      nvm alias default node
      default_version=$(nvm version default)
    fi

    # If the current version is not the default version, set it to use the default version
    if [ "$(nvm current)" != "${default_version}" ]; then
      nvm use default
    fi
  elif [[ -s "${nvm_path}/.nvmrc" && -r "${nvm_path}/.nvmrc" ]]; then
    declare nvm_version
    nvm_version=$(<"${nvm_path}"/.nvmrc)

    declare locally_resolved_nvm_version
    # `nvm ls` will check all locally-available versions
    # If there are multiple matching versions, take the latest one
    # Remove the `->` and `*` characters and spaces
    # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
    locally_resolved_nvm_version=$(nvm ls --no-colors "${nvm_version}" | command tail -1 | command tr -d '\->*' | command tr -d '[:space:]')

    # If it is not already installed, install it
    # `nvm install` will implicitly use the newly-installed version
    if [ "${locally_resolved_nvm_version}" = 'N/A' ]; then
      nvm install "${nvm_version}"
    elif [ "$(nvm current)" != "${locally_resolved_nvm_version}" ]; then
      nvm use "${nvm_version}"
    fi
  fi
}

rnv "$PWD" || exit
# ^^^ nvm automatic version detection ^^^

# vvv yazi automatic current working directory changing after exiting vvv

function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ^^^ yazi automatic current working directory changing after exiting ^^^

# THIS MUST E AT THE END
eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
