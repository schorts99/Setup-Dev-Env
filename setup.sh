#!/bin/bash

source ./tools/homebrew.sh
source ./tools/github.sh
source ./tools/git.sh
source ./tools/neovim.sh
source ./tools/fnm.sh
source ./tools/nodejs.sh
source ./tools/nvchad.sh
source ./tools/claude_code.sh
source ./tools/copilot.sh
source ./tools/gemini.sh

echo "-------------------------------------------------------"
echo "Welcome from schorts (https://github.com/schorts99)"
echo "-------------------------------------------------------"
echo "This script will install:"
echo "1. Homebrew: The Missing Package Manager for macOS (or Linux)."
echo "2. Git: A free and open source distributed version control system."
echo "3. GitHub: A GitHub on the command line."
echo "4. NeoVim: A hyper-extensible Vim-based text editor."
echo "5. FNM: A fast and simple Node.js version manager."
echo "6. Node.js: A JavaScript runtime environment."
echo "7. NvChad: A blazing fast Neovim config providing solid defaults and a beautiful UI."
echo "8. Claude Code: An agentic coding tool that lives in your terminal."
echo "9. Copilot: An AI-powered coding assistance directly to your command line."
echo "10. Gemini: An AI agent that brings the power of Gemini directly into your terminal."
echo "-------------------------------------------------------"

read -p "Do you want to proceed? (Y/n): " confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

mkdir -p ~/.local/bin

setup_homebrew
setup_git
setup_github
setup_neovim
setup_fnm
setup_nodejs
setup_nvchad
setup_claude_code
setup_copilot
setup_gemini

