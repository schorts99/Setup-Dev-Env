# Setup Dev Environment

A streamlined, modular setup for macOS and Unix environments. This repository provides a two-stage process: Installation of core developer tools and Configuration of those tools to match a specific workflow.

## 🚀 Overview

This repository is designed for developers who want a "batteries-included" terminal experience. It automates the installation of modern CLI tools, AI agents, and a pre-configured Neovim environment.

### 📦 Tools Installed

- **Package Managers**: Homebrew, FNM (Node), PyENV (Python), PNPM.
- **Editor**: [NeoVim](https://neovim.io) with [NvChad](https://nvchad.com) for a blazing-fast, beautiful UI.
- **AI Agents**:
  - **Claude Code**: Agentic coding in the terminal.
  - **GitHub Copilot**: AI assistance for the CLI.
  - **Gemini**: Google's AI power directly in your terminal.

## 🛠 Usage

The setup is split into two main scripts to separate concerns:

### 1. The Setup Script (`setup.sh`)

Handles the installation of all binary dependencies and language runtimes.

```bash
chmod +x setup.sh
./setup.sh
```

### 2. The Config Script (`config.sh`)

Applies personal preferences and environment settings once tools are present.

```bash
chmod +x config.sh
./config.sh
```

## 🏗 Language Runtimes

The script ensures you aren't just using "System" languages, but manageable versions:

### Node.js (via FNM)

Uses FNM (Fast Node Manager) to handle versions. This allows for lightning-fast switching between Node releases and keeps your global environment clean.

### Python (via PyENV)

Uses PyENV to manage multiple Python versions. This prevents conflicts between the macOS system Python and your project-specific requirements.

## 🔧 Applied Configurations

The configuration logic is modular and idempotent, ensuring that settings are applied only if they don't already exist, or updated if they do.

- **Indentation Management**:
  - Uses Tabs instead of spaces.
  - Configures `tabstop`, `shiftwidth`, and `softtabstop` to `2`.
  - Automatically adds a clean -- Indentation Settings header in `init.lua` if missing.
- **JavaScript Environment**:
  - LSP Integration: Automatically configures `vtsls` for intelligent code completion and error checking.
  - Future-Proof: Utilizes the native `vim.lsp.config` (Neovim 0.11+ standard) for LSP management.
  - Formatting: Integrates with `conform.nvim` to enforce prettier on save.
