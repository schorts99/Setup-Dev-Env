#!/bin/bash

source ./tools/homebrew.sh
source ./tools/github.sh
source ./tools/git.sh
source ./tools/neovim.sh
source ./tools/nodejs.sh
source ./tools/pnpm.sh
source ./tools/nvchad.sh
source ./tools/claude_code.sh
source ./tools/copilot.sh
source ./tools/antigravity.sh
source ./tools/pyenv.sh
source ./tools/python.sh
source ./tools/phpbrew.sh
source ./tools/terraform.sh
source ./tools/jules.sh
source ./tools/codex.sh
source ./tools/mise.sh
source ./tools/ruby.sh

url="https://github.com/schorts99"
text="schorts"

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[0;34m'
PURPLE=$'\033[0;35m'
CYAN=$'\033[0;36m'
NC=$'\033[0m'

echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   /_/\    Welcome from \e]8;;${url}\e\\${text}\e]8;;\e\\${NC}"
echo -e "${GREEN}  ( o.o )  ${NC}"
echo -e "${GREEN}   > ^ <   Your new dev environment setup buddy!${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e ""
echo -e "${YELLOW}This script will install the following awesome tools:${NC}"
echo -e ""

printf "${BLUE}%-18s${NC}%s\n" \
    "01. Git"          " - Distributed version control system" \
    "02. Homebrew"     " - The missing package manager for macOS (and Linux)" \
    "03. GitHub CLI"   " - GitHub right in your terminal" \
    "04. NeoVim"       " - Hyperextensible Vim-based text editor" \
		"05. Mise"				 " - One tool that manages dev tools, env vars, and tasks per project" \
    "06. Node.js"      " - JavaScript runtime built on Chrome's V8 engine" \
    "07. PNPM"         " - Fast, disk-efficient package manager" \
    "08. NvChad"       " - Beautiful, blazing-fast Neovim config" \
    "09. Claude Code"  " - Agentic coding assistant in your terminal" \
    "10. Copilot"      " - AI-powered coding companion for the CLI" \
    "11. Antigravity"  " - AI agent that builds, debugs, and ships from your terminal" \
    "12. PyENV"        " - Simple Python version management" \
    "13. Python"       " - Powerful, versatile programming language" \
    "14. PHPbrew"      " - PHP version manager" \
    "15. Terraform"    " - Infrastructure as code made simple" \
		"16. Jules"        " - Coding agent that helps you fix bugs, add documentation, and build new features" \
		"17. Codex"				 " - Completes tasks end to end, like building features, complex refactors, migrations, and more" \
		"18. Ruby"				 " - Ruby is an interpreted object-oriented programming language often used for web development"

echo -e ""
echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Ready to supercharge your development setup? Let's go! 🚀${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e ""

echo -e "${YELLOW}───────────────────────────────────────────────────────${NC}"
read -p "${GREEN}Do you want to proceed with the installation? (Y/n): ${NC}" confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]] || [[ $confirm =~ ^[Nn][Oo]$ ]]; then
    echo -e "${RED}Installation cancelled by user.${NC}"
    echo -e "${CYAN}Come back anytime when you're ready! 👋${NC}"
    exit 0
fi

echo -e "${GREEN}Starting installation... 🚀${NC}"
echo -e ""

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
setup_mise
setup_nodejs
setup_pnpm
setup_nvchad
setup_claude_code
setup_copilot
# setup_antigravity
# setup_pyenv
# setup_python
# setup_phpbrew
# setup_terraform
# setup_jules
# setup_codex
# setup_ruby
