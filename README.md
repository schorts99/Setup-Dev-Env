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
  - **Antigravity**: Build, debug, and ship from your terminal.
  - **Codex**: Complete tasks end-to-end like building features, complex refactors, and migrations.

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

### 3. The Kitty Script (`kitty.sh`)

Installs [Kitty](https://sw.kovidgoyal.net/kitty), a GPU-accelerated terminal emulator.

```bash
chmod +x kitty.sh
./kitty.sh
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
  - LSP Integration: Configures vtsls using the native vim.lsp.config (Neovim 0.11+) standard.
  - Formatting: Uses `conform.nvim` to enforce prettier for both `.js` and `.jsx` files.
- **TypeScript Environment**:
  - Advanced LSP: Enables Inlay Hints (parameter names, variable types, enum values) for deep code clarity.
  - DX Features: Enables updateImportsOnFileMove and function call suggestions.
  - React Support: Full formatting and LSP support for .tsx files, including nvim-ts-autotag integration for JSX tags.
- **Shell Script Environment**:
  - LSP Integration: Configures bashls for Bash, Sh, and Zsh support.
  - Linting: Integrated support for shellcheck (via LSP) to catch common scripting pitfalls.
  - Formatting: Uses shfmt through conform.nvim to keep scripts clean and readable.
- **Markdown Environment**:
  - LSP Server: Integrates marksman for markdown and MDX linting.
  - Code Formatting: prettier via conform.nvim for `.md` and `.mdx` files.
  - Preview Mode: markdown-preview.nvim with keybindings (`<leader>mp` for toggle, `<leader>ms` for start, `<leader>mq` for stop).
  - Global Dependencies: prettier and @fsouza/prettierd installed globally via pnpm.
- **Node.js Development**:
  - Dedicated configuration for Node.js development settings and tooling.
- **NestJS Framework**:
  - Framework-specific configuration for NestJS development.
- **Vue.js Support**:
  - Full Vue.js development environment with LSP and formatting support.
- **Svelte Support**:
  - Svelte framework configuration with language server integration.
- **File Explorer**:
  - Configured file navigation within NeoVim for efficient project browsing.
