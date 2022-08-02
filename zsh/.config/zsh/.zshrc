#!/bin/zsh

stty stop undef 	# disable ctrl+s freeze terminal
setopt menucomplete
setopt appendhistory
unsetopt beep		# beeping is annoying

eval $(thefuck --alias)

source "$ZDOTDIR/zsh-functions"	# useful functions
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

#Plugins
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"

