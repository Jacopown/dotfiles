#! /usr/bin/env zsh

script_dir="$( cd "$( dirname "${(%):-%x}" )" &> /dev/null && pwd )"
dry_run="${dry_run:-0}"

source "$script_dir/utils.sh"

OS="$(uname -s)"

COMMON_PKGS=(
    git
    fzf
    tmux
)

LINUX_PKGS=(
    npm # needed for installing bashls
    firefox
    telegram-desktop
    vesktop
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk # for broken GUIs in discord and safari
)

MAC_PKGS=(
    node # includes npm
)

if [[ "$OS" == "Linux" ]]; then
    if command -v paru &> /dev/null; then
        INSTALL_CMD=(paru -S --needed --noconfirm)
    else
        INSTALL_CMD=(sudo pacman -S --needed --noconfirm)
    fi
    OS_PKGS=("${LINUX_PKGS[@]}")
elif [[ "$OS" == "Darwin" ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Error: Homebrew not found. Install it from https://brew.sh/" >&2
        exit 1
    fi
    INSTALL_CMD=(brew install)
    OS_PKGS=("${MAC_PKGS[@]}")
else
    echo "Error: Unsupported operating system: $OS" >&2
    exit 1
fi

if (( ${#COMMON_PKGS[@]} > 0 )); then
    run_cmd "${INSTALL_CMD[@]}" "${COMMON_PKGS[@]}"
fi

if (( ${#OS_PKGS[@]} > 0 )); then
    run_cmd "${INSTALL_CMD[@]}" "${OS_PKGS[@]}"
fi
