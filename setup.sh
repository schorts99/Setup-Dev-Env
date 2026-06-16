#!/bin/bash

source ./tools/homebrew.sh
source ./tools/github.sh
source ./tools/git.sh
source ./tools/neovim.sh
source ./tools/fnm.sh
source ./tools/nodejs.sh
source ./tools/pnpm.sh
source ./tools/nvchad.sh
source ./tools/claude_code.sh
source ./tools/copilot.sh
source ./tools/gemini.sh
source ./tools/pyenv.sh
source ./tools/python.sh
source ./tools/phpbrew.sh

echo "-------------------------------------------------------"
echo "Welcome from schorts (https://github.com/schorts99)"
echo "-------------------------------------------------------"
echo "This script will install:"
echo "1. Git: A free and open source distributed version control system."
echo "2. Homebrew: The Missing Package Manager for macOS (or Linux)."
echo "3. GitHub: A GitHub on the command line."
echo "4. NeoVim: A hyper-extensible Vim-based text editor."
echo "5. FNM: A fast and simple Node.js version manager."
echo "6. Node.js: A JavaScript runtime environment."
echo "7. PNPM: Save time. Save disk space. Supercharge your monorepos."
echo "8. NvChad: A blazing fast Neovim config providing solid defaults and a beautiful UI."
echo "9. Claude Code: An agentic coding tool that lives in your terminal."
echo "10. Copilot: An AI-powered coding assistance directly to your command line."
echo "11. Gemini: An AI agent that brings the power of Gemini directly into your terminal."
echo "12. PyENV: pyenv lets you easily switch between multiple versions of Python."
echo "13. Python: Programming language that lets you work quickly and integrate systems more effectively."
echo "14. PHPbrew: Brew & manage PHP versions in pure PHP at HOME."
echo "-------------------------------------------------------"

read -p "Do you want to proceed? (Y/n): " confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]]; then
	echo "Installation cancelled."
	exit 0
fi

mkdir -p ~/.local/bin

PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'

if [[ "$SHELL" == *"zsh"* ]]; then
  CONF_FILE="$HOME/.zshrc"
else
  CONF_FILE="$HOME/.bashrc"
fi

if ! grep -Fq "$PATH_LINE" "$CONF_FILE"; then
  echo "$PATH_LINE" >> "$CONF_FILE"
  source "$CONF_FILE"
fi

setup_homebrew
setup_git
setup_github
setup_neovim
setup_fnm
setup_nodejs
setup_pnpm
setup_nvchad
setup_claude_code
setup_copilot
setup_gemini
setup_pyenv
setup_python
setup_phpbrew
