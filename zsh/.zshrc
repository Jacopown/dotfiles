# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "$HOME/.config/zsh/exports.zsh"

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/sudo"
plug "conda-incubator/conda-zsh-completion"
plug "wintermi/zsh-lsd"
# History substring search keybinds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Load and initialise completion system
autoload -Uz compinit
compinit

plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

alias dot="cd ~/Repo/dotfiles/ && la"
