#!/usr/bin/env zsh

dry_run="${dry_run:-0}"
if [[ "$1" == "--dry" ]]; then
    dry_run="1"
fi

log() {
    if [[ "$dry_run" == "1" ]]; then
        echo "[DRY_RUN]: $*"
    else
        echo "$*"
    fi
}

run_cmd() {
    log "running command: $*"
    if [[ "$dry_run" == "0" ]]; then
        "$@"
    fi
}

ensure_pkg() {
    local cmd_name="$1"
    local pkg_name="${2:-$cmd_name}"

    if command -v "$cmd_name" &> /dev/null; then
        log "$cmd_name is already installed."
        return 0
    fi

    log "$cmd_name not found. Installing package: $pkg_name"

    local os="$(uname -s)"
    if [[ "$os" == "Darwin" ]]; then
        if ! command -v brew &> /dev/null; then
            echo "Error: Homebrew not found. Install it from https://brew.sh/" >&2
            return 1
        fi
        run_cmd brew install "$pkg_name"
    elif [[ "$os" == "Linux" ]]; then
        if command -v paru &> /dev/null; then
            run_cmd paru -S --needed --noconfirm "$pkg_name"
        else
            run_cmd sudo pacman -S --needed --noconfirm "$pkg_name"
        fi
    else
        echo "Error: Unsupported operating system: $os" >&2
        return 1
    fi
}

remove_file() {
    local target="$1"

    if [[ -L "$target" ]]; then
        log "Removing old symlink: $target"
        if [[ "$dry_run" == "0" ]]; then
            rm "$target"
        fi
    elif [[ -e "$target" ]]; then
        log "Existing real file/dir found at $target: creating backup at ${target}.bak"
        if [[ "$dry_run" == "0" ]]; then
            mv "$target" "${target}.bak"
        fi
    fi
}

link_file() {
    local src="$1"
    local dst="$2"

    # check if link already exists and points to src
    if [[ -L "$dst" ]] && [[ "$(readlink "$dst")" == "$src" ]]; then
        log "Link $dst already points to $src, skipping."
        return 0
    fi

    # if destination is a symlink pointing elsewhere or broken, remove it directly
    if [[ -L "$dst" ]]; then
        log "Removing old symlink at $dst"
        if [[ "$dry_run" == "0" ]]; then
            rm "$dst"
        fi
    # if destination is a real file or directory, back it up safely
    elif [[ -e "$dst" ]]; then
        log "Existing real file/dir found at $dst: creating backup at ${dst}.bak"
        if [[ "$dry_run" == "0" ]]; then
            mv "$dst" "${dst}.bak"
        fi
    fi

    local dst_dir="$(dirname "$dst")"
    if [[ ! -d "$dst_dir" ]]; then
        if [[ "$dry_run" == "0" ]]; then
            mkdir -p "$dst_dir"
        fi
    fi

    log "Linking: $src -> $dst"
    if [[ "$dry_run" == "0" ]]; then
        ln -s "$src" "$dst"
    fi
}
