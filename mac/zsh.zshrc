export PATH=/opt/homebrew/bin:~/bin:/usr/local/bin:$PATH
export ZSH=~/.oh-my-zsh
export LANG=en_US.UTF-8
export STARSHIP_CONFIG=~/bin/settings/mac/starship.toml

ZSH_THEME="dracula"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias neovide="/Applications/Neovide.app/Contents/MacOS/neovide --fork"
alias zed="/Applications/Zed.app/Contents/MacOS/zed"

# opencode
export PATH=/Users/zyq/.opencode/bin:$PATH

# bun completions
[ -s "/Users/zyq/.bun/_bun" ] && source "/Users/zyq/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"
