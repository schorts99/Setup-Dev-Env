#!/bin/bash

source ./configs/nvim.sh

echo "-------------------------------------------------------"
echo "Welcome from schorts (https://github.com/schorts99)"
echo "-------------------------------------------------------"
echo "This script will config:"
echo "1. NeoVim: A hyper-extensible Vim-based text editor."
echo "-------------------------------------------------------"

read -p "Do you want to proceed? (Y/n): " confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]]; then
	echo "Configuration cancelled."
	exit 0
fi

config_nvim
