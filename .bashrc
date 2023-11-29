#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pn='pnpm'
alias ls='exa'
alias v='nvim'
alias lv='NVIM_APPNAME=LazyVim nvim'
alias z='zoxide'
alias zz='zoxide -'
alias zl='zellij'
alias r='ranger'
alias lg='lazygit'
alias shut='shutdown now'
alias susp='systemctl suspend'
# alias hiber='systemctl hibernate'
alias sshalive='ssh -v -o ServerAliveInterval=60'
alias config='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# PS1='[\u@\h \W]\$ '

alias keycodes='xev | awk -F"[ )]+" "/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\\n\", \$5, \$8 }"'

export EDITOR='nvim'
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

eval $(keychain --eval --quiet github-civil slapab_gitlab_rndlab_online)

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# THIS MUST E AT THE END
eval "$(starship init bash)"
eval "$(zoxide init bash)"
