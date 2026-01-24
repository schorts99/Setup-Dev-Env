#!/bin/bash

source ./tools/neovim.sh
source ./tools/fnm.sh

echo "-------------------------------------------------------"
echo "Welcome from schorts (https://github.com/schorts99)"
echo "-------------------------------------------------------"
echo "This script will install:"
echo "1. NeoVim: A hyper-extensible Vim-based text editor."
echo "2. FNM: A fast and simple Node.js version manager"
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

