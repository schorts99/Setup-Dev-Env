#!/bin/bash

source ./tools/neovim.sh

echo "-------------------------------------------------------"
echo "Welcome from schorts (https://github.com/schorts99)"
echo "-------------------------------------------------------"
echo "This script will install:"
echo "1. NeoVim: A hyper-extensible Vim-based text editor."
echo "2. NvChad: A blazing fast Neovim config (IDE-like UI)."
echo "-------------------------------------------------------"

read -p "Do you want to proceed? (Y/n): " confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

mkdir -p ~/.local/bin

setup_neovim

