#!/usr/bin/env zsh
set -e

script_dir="$( cd "$( dirname "${(%):-%x}" )" &> /dev/null && pwd )"
source "$script_dir/install/utils.sh"

log "Starting setup..."

log "-> Installing base packages"
"$script_dir/install/base.sh" "$@"

log "-> Setting up tmux"
"$script_dir/install/tmux.sh" "$@"

log "-> Setting up zsh"
"$script_dir/install/zsh.sh" "$@"

log "Done!"
