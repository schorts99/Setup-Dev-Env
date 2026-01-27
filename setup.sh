#!/bin/bash

source ./tools/neovim.sh
source ./tools/fnm.sh
source ./tools/nodejs.sh
source ./tools/homebrew.sh
source ./tools/nvchad.sh

echo "-------------------------------------------------------"
echo "Welcome from schorts (https://github.com/schorts99)"
echo "-------------------------------------------------------"
echo "This script will install:"
echo "1. NeoVim: A hyper-extensible Vim-based text editor."
echo "2. FNM: A fast and simple Node.js version manager."
echo "3. Node.js: A JavaScript runtime environment."
echo "4. Homebrew: The Missing Package Manager for macOS (or Linux)."
echo "5. NvChad: A blazing fast Neovim config providing solid defaults and a beautiful UI."
echo "-------------------------------------------------------"

read -p "Do you want to proceed? (Y/n): " confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

mkdir -p ~/.local/bin

setup_neovim
setup_fnm
setup_nodejs
setup_homebrew
setup_nvchad

