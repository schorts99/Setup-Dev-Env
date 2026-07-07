#!/bin/bash

source ./configs/nvim.sh
source ./configs/git.sh

echo "-------------------------------------------------------"
echo "Welcome from schorts (https://github.com/schorts99)"
echo "-------------------------------------------------------"
echo "This script will config:"
echo "1. NeoVim: A hyper-extensible Vim-based text editor."
echo "2. Git: A free and open source distributed version control system."
echo "-------------------------------------------------------"

read -p "Do you want to proceed? (Y/n): " confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]]; then
	echo "Configuration cancelled."

	exit 0
fi

config_nvim
config_git
