#!/bin/bash

source ./configs/nvim.sh
source ./configs/git.sh

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[0;34m'
CYAN=$'\033[0;36m'
NC=$'\033[0m'

url="https://github.com/schorts99"
text="schorts"

echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   /_/\    Welcome from \e]8;;${url}\a${text}\e]8;;\a${NC}"
echo -e "${GREEN}  ( o.o )  ${NC}"
echo -e "${GREEN}   > ^ <   Your new dev environment config buddy!${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e ""

echo -e "${YELLOW}This script will configure the following:${NC}"
echo -e ""
printf "${BLUE}%-12s${NC}%s\n" \
    "1. NeoVim"   " - Hyper-extensible Vim-based text editor with NvChad" \
    "2. Git"      " - Distributed version control system"

echo -e ""
echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Ready to configure your development environment? Let's go! 🚀${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
echo -e ""

echo -e "${YELLOW}───────────────────────────────────────────────────────${NC}"

read -p "${GREEN}Do you want to proceed with the configuration? (Y/n): ${NC}" confirm
confirm=${confirm:-Y}

if [[ $confirm =~ ^[Nn]$ ]] || [[ $confirm =~ ^[Nn][Oo]$ ]]; then
    echo -e "${RED}Configuration cancelled by user.${NC}"
    echo -e "${CYAN}Come back anytime when you're ready! 👋${NC}"
    exit 0
fi

echo -e "${GREEN}Starting configuration... 🚀${NC}"
echo -e ""

config_nvim
config_git
