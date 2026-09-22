#! /usr/bin/env zsh
script_dir="$( cd "$( dirname "${(%):-%x}" )" &> /dev/null && pwd )"
dry_run="${dry_run:-0}"

source "$script_dir/utils.sh"

ensure_pkg tmux

# tmux-sessionizer in ~/.local/share and symlinked to ~/.local/bin (no sudo required)
sessionizer_dir="$HOME/.local/share/tmux-sessionizer"
if ! command -v "tmux-sessionizer" &> /dev/null; then
  mkdir -p "$HOME/.local/bin"
  if [[ ! -d "$sessionizer_dir" ]]; then
    log "Cloning tmux-sessionizer into $sessionizer_dir"
    if [[ "$dry_run" == "0" ]]; then
      git clone https://github.com/ThePrimeagen/tmux-sessionizer.git "$sessionizer_dir"
    fi
  fi
  link_file "$sessionizer_dir/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
fi

dotfiles_dir="$( cd "$script_dir/.." &> /dev/null && pwd )"
src_tmux_dir="$dotfiles_dir/tmux"

remove_file "$HOME/.tmux.conf"
remove_file "$HOME/.tmux"

link_file "$src_tmux_dir" "$HOME/.config/tmux"


