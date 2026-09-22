#! /usr/bin/env zsh
script_dir="$( cd "$( dirname "${(%):-%x}" )" &> /dev/null && pwd )"
dry_run="${dry_run:-0}"

source "$script_dir/utils.sh"

ensure_pkg zsh

# Install Mamba / Micromamba if missing
if ! command -v "mamba" &> /dev/null && ! command -v "micromamba" &> /dev/null; then
  log "running command: ${SHELL} <(curl -L micro.mamba.pm/install.sh)"
  if [[ "$dry_run" == "0" ]]; then
    "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
  fi
fi

dotfiles_dir="$( cd "$script_dir/.." &> /dev/null && pwd )"

link_file "$dotfiles_dir/zsh/.zshrc" "$HOME/.zshrc"
link_file "$dotfiles_dir/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
