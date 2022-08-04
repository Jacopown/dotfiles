#!/bin/zsh

stty stop undef 	# disable ctrl+s freeze terminal
setopt menucomplete
setopt appendhistory
unsetopt beep		# beeping is annoying

# Now pressing  or  after u typed a command will cycle throught history of that command only
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

eval $(thefuck --alias)

source "$ZDOTDIR/zsh-functions"	# useful functions
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

#Plugins
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"

# Keybindings
bindkey '^[[A' up-line-or-beginning-search # Up
bindkey '^[[B' down-line-or-beginning-search # Down
