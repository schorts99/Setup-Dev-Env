# Setup Dev Environment - Project Context

**Project**: Setup-Dev-Env  
**Author**: schorts99 (https://github.com/schorts99)  
**Type**: Bash-based automated development environment provisioning system  
**Language**: Shell Script (Bash)  
**Purpose**: Streamlined, modular setup for macOS and Unix environments with automated installation of developer tools, language runtimes, and AI agents.

---

## 📋 Project Overview

This is a **two-stage provisioning system** that separates concerns:

1. **Setup Phase** (`setup.sh`) - Installs core binaries and dependencies
2. **Configuration Phase** (`config.sh`) - Applies personal preferences and environment settings

The approach is **modular**, **idempotent**, and **reusable**, using shell sourcing to load tool-specific installation/configuration scripts.

---

## 🎯 Project Goals

- Automate installation of modern CLI tools for developers
- Provide a consistent development environment across systems
- Integrate AI agents (Claude Code, GitHub Copilot, Antigravity)
- Configure NeoVim with language-specific features
- Manage multiple language runtimes (Node.js, Python) with version managers

---

## 🏗 Project Structure

```
Setup-Dev-Env/
├── README.md                 # Project documentation
├── setup.sh                  # Main setup orchestrator (installs binaries)
├── config.sh                 # Main config orchestrator (applies settings)
├── kitty.sh                  # Terminal emulator installation script
├── tools/                    # Tool-specific installation scripts (320 lines total)
│   ├── homebrew.sh          # Package manager setup
│   ├── git.sh               # Git configuration
│   ├── github.sh            # GitHub CLI setup
│   ├── neovim.sh            # NeoVim installation
│   ├── fnm.sh               # Fast Node Manager installation
│   ├── nodejs.sh            # Node.js setup via FNM
│   ├── pnpm.sh              # PNPM package manager
│   ├── nvchad.sh            # NvChad configuration framework
│   ├── pyenv.sh             # Python version manager (44 lines)
│   ├── python.sh            # Python installation
│   ├── claude_code.sh        # Claude Code agent setup
│   ├── copilot.sh           # GitHub Copilot CLI setup
│   ├── antigravity.sh       # Antigravity build tool setup
│   ├── phpbrew.sh           # PHP version manager
│   ├── terraform.sh         # Terraform IaC tool
│   └── jules.sh             # Jules tool
├── configs/                 # Configuration scripts
│   ├── nvim.sh              # Main NeoVim configuration orchestrator
│   ├── git.sh               # Git configuration
│   └── nvim/                # NeoVim-specific configuration modules
│       ├── indentation.sh   # Tab settings (tabstop=2, shiftwidth=2)
│       ├── js.sh            # JavaScript/JSX configuration
│       ├── ts.sh            # TypeScript/TSX configuration
│       ├── shell.sh         # Bash/Sh/Zsh configuration
│       ├── node.sh          # Node.js development settings
│       ├── nest.sh          # NestJS framework configuration
│       ├── vue.sh           # Vue.js configuration
│       ├── svelte.sh        # Svelte configuration
│       └── file_explorer.sh # File explorer setup
└── .git/                    # Git repository metadata
```

---

## 🔧 Tools & Dependencies Installed

### Package Managers
- **Homebrew** - macOS/Linux package manager
- **FNM** - Fast Node.js version manager (13 lines)
- **PyENV** - Python version manager (44 lines)
- **PNPM** - Fast, disk-efficient Node package manager (15 lines)

### Core Developer Tools
- **Git** - Version control (19 lines)
- **GitHub CLI** - GitHub from terminal (16 lines)
- **NeoVim** - Text editor (18 lines)
- **Kitty** - GPU-accelerated terminal emulator

### Language Runtimes
- **Node.js** - JavaScript runtime via FNM (27 lines)
- **Python** - Python runtime via PyENV (16 lines)
- **PHP** - PHP runtime via phpbrew (25 lines)
- **Terraform** - Infrastructure as Code (14 lines)

### AI & Development Agents
- **Claude Code** - Agentic coding assistant (13 lines)
- **GitHub Copilot CLI** - AI-powered coding companion (13 lines)
- **Antigravity** - Build/debug/ship tool (14 lines)
- **Jules** - Development utility (13 lines)

### Editor Configurations
- **NvChad** - Pre-configured NeoVim framework (29 lines)

---

## 📐 Architecture & Design Patterns

### Module Sourcing Pattern
```bash
# setup.sh sources all tool installers
source ./tools/homebrew.sh
source ./tools/neovim.sh
# ... etc

# config.sh sources all configuration modules
source ./configs/nvim.sh
source ./configs/git.sh
```

### Installation Pattern (Idempotent)
Each tool script follows this pattern:
```bash
setup_<tool>() {
  if command -v <tool> >/dev/null 2>&1; then
    echo "✅ Tool is already installed"
    return 0
  fi
  
  echo "Starting installation..."
  # Installation logic
  echo "✅ Tool installed"
}
```

### Configuration Pattern (NeoVim)
NeoVim configuration is modular:
- `$NVIM_DIR/.config/nvim` - Main NeoVim config directory
- `$CONF_DIR=$NVIM_DIR/lua/configs/$USER` - User-specific configurations
- Each language gets dedicated config: `js.sh`, `ts.sh`, `shell.sh`, etc.

### File Organization
- Indentation settings applied globally
- Language-specific LSP, formatting, and linting configurations
- Config modules automatically imported via `require('configs.$USER')`

---

## 🎨 Key Configuration Features

### Indentation Management
- Uses **Tabs** instead of spaces
- `tabstop`, `shiftwidth`, `softtabstop` all set to `2`
- Applied via `configs/nvim/indentation.sh`
- Auto-adds "-- Indentation Settings" header to init.lua if missing

### JavaScript Environment (`js.sh`)
- **LSP**: vtsls via vim.lsp.config (Neovim 0.11+ standard)
- **Formatting**: conform.nvim with prettier for `.js` and `.jsx`
- Automatic on-save formatting

### TypeScript Environment (`ts.sh`)
- **Advanced LSP**: Inlay hints (parameters, types, enums)
- **DX Features**: updateImportsOnFileMove, function call suggestions
- **React Support**: Full formatting for `.tsx`, nvim-ts-autotag for JSX

### Shell Script Environment (`shell.sh`)
- **LSP**: bashls for Bash, Sh, Zsh
- **Linting**: shellcheck integration
- **Formatting**: shfmt via conform.nvim

### Framework-Specific Configs
- **Node.js** (`node.sh`) - Node development settings
- **NestJS** (`nest.sh`) - NestJS framework configuration
- **Vue** (`vue.sh`) - Vue.js support
- **Svelte** (`svelte.sh`) - Svelte framework support

### File Explorer
- Configured via `file_explorer.sh`
- Integration with NeoVim's built-in or plugin-based file navigation

---

## 🚀 Execution Flow

### Setup Phase
1. Source all tool installation scripts
2. Display welcome message with colored output (ANSI escape codes)
3. List all tools to be installed
4. For each tool, call `setup_<tool>`:
   - Check if already installed
   - Install via brew (primary method)
   - Configure shell environment (bash/zsh)
   - Update PATH and shell config files

### Configuration Phase
1. Source all configuration scripts
2. Display welcome message
3. Ask for user confirmation
4. Call config functions:
   - `config_nvim` - Applies all NeoVim configurations
   - `config_git` - Git settings

### Key Variables
- `$USER` - Current user (used for NeoVim config paths)
- `$NVIM_DIR` - `~/.config/nvim`
- `$CONF_DIR` - `~/.config/nvim/lua/configs/$USER`
- `$ROOT_INIT` - `~/.config/nvim/init.lua`
- Color variables: `RED`, `GREEN`, `YELLOW`, `BLUE`, `CYAN`, `NC`

---

## 📝 Shell Scripting Conventions

### Color Output
```bash
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[0;34m'
CYAN=$'\033[0;36m'
NC=$'\033[0m'  # No Color
```

### Helper Patterns
- `command -v <tool>` - Check if tool is installed
- `>/dev/null 2>&1` - Suppress output
- `return 0` - Success (idempotent check)
- `return 1` - Failure
- `-f` flag - Check if file exists
- `eval "$(...)"` - Execute command expansion result

### Directory Handling
```bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```
Get script's directory (used in configs/nvim.sh)

### Shell Compatibility
- Scripts support both **macOS** (zsh in `.zprofile`) and **Linux** (bash in `.bashrc`)
- Checks for shell type: `if [[ "$SHELL" == *"zsh"* ]]`

---

## 📊 Code Statistics

| Component | Lines | Type |
|-----------|-------|------|
| setup.sh | ~70 | Main orchestrator |
| config.sh | ~50 | Main orchestrator |
| kitty.sh | ~30 | Installer |
| Homebrew | 31 | Installer |
| PyENV | 44 | Installer (largest) |
| Terraform | 14 | Installer (smallest) |
| **Total Tools** | **320** | Installers |
| **Total Project** | **386** | All scripts |

---

## ✅ Rules & Best Practices for Development

### 1. **Idempotency Requirement**
- Every setup and config function MUST check if already applied
- Use `if command -v` for binary checks
- Use `if [[ -f ]]` for file checks
- Never overwrite without checking first

### 2. **Shell Compatibility**
- Support both **macOS** (zsh) and **Linux** (bash)
- Use `if [[ "$SHELL" == *"zsh"* ]]` to detect shell
- Update appropriate shell config: `.zprofile` (macOS) or `.bashrc` (Linux)

### 3. **Module Sourcing Pattern**
```bash
# Always use local sourcing with proper directory resolution
source "$DIR/path/to/module.sh"
# Call functions after sourcing
function_name
```

### 4. **Error Handling**
```bash
if ! command -v tool >/dev/null 2>&1; then
    echo "❌ Tool is not installed"
    return 1
fi
```

### 5. **Directory Management**
```bash
# Get script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create directories with parent structure
mkdir -p "$CONF_DIR"
touch "$CONF_DIR/init.lua"
```

### 6. **User-Specific Configuration**
- Use `$USER` variable for personalization
- Store user configs in `~/.config/nvim/lua/configs/$USER`
- Allow multiple users on same system

### 7. **NeoVim Configuration Structure**
- Main config: `~/.config/nvim/init.lua`
- User-specific: `~/.config/nvim/lua/configs/$USER/init.lua`
- Language-specific: Load from main init.lua via require statements
- Each language gets dedicated configuration module

### 8. **Color Output Standards**
- Use consistent ANSI color codes
- ✅ for success messages (GREEN)
- ❌ for errors (RED)
- 🚀 for progress (CYAN/BLUE)
- Use `echo -e` for color rendering

### 9. **Naming Conventions**
- Functions: `setup_<tool>`, `config_<feature>`
- Files: lowercase with underscores
- Variables: UPPERCASE for constants, lowercase for locals
- Colors: Descriptive names (RED, GREEN, etc.)

### 10. **Package Manager Priority**
- Primary: Homebrew (works on macOS and Linux)
- Fallback: Direct installation (curl-based)
- Language-specific managers: FNM (Node), PyENV (Python)

### 11. **Logging & Communication**
```bash
echo "Starting Installation..."     # Informational
echo "✅ Tool installed"            # Success
echo "❌ Tool not installed"        # Error  
echo "🚀 Status update"             # Progress
```

### 12. **Path Management**
- Evaluate PATH after installation
- Update shell config files appropriately
- Use `eval` to execute shell configuration commands

### 13. **File Operations Safety**
- Always check file existence before sourcing
- Use `mkdir -p` for directory creation
- Use `touch` to create files safely
- Preserve existing content when appending

### 14. **Testing Checklist Before Commit**
- [ ] Script runs without errors
- [ ] Idempotency verified (can run multiple times)
- [ ] Works on both macOS and Linux
- [ ] Color output renders correctly
- [ ] Documentation updated
- [ ] Follows naming conventions
- [ ] No hardcoded paths (use variables)
- [ ] Error messages are clear

---

## 🔍 Common Modification Points

When adding new tools:

1. Create `tools/<tool>.sh` with `setup_<tool>()` function
2. Add `source ./tools/<tool>.sh` to `setup.sh`
3. Call `setup_<tool>` in the appropriate order (dependencies first)
4. If configuration needed, create `configs/<feature>.sh`
5. Add `source ./configs/<feature>.sh` to `config.sh`
6. Call `config_<feature>` in config orchestrator

When adding NeoVim configs:

1. Create `configs/nvim/<feature>.sh` with `config_<feature>()` function
2. Add `source "$DIR/nvim/<feature>.sh"` to `configs/nvim.sh`
3. Call `config_<feature>` inside `config_nvim()` function
4. Update lua config path: `$CONF_DIR/init.lua`
5. Add require statement to main init.lua if needed

---

## 🎯 Future Enhancement Areas

Based on project structure:

1. **Dependency Management** - Add explicit dependency order (e.g., Homebrew before tools)
2. **Error Recovery** - Add rollback or cleanup on failure
3. **Dry-run Mode** - Add `--dry-run` flag to preview changes
4. **Uninstall Scripts** - Add cleanup/uninstall functionality
5. **Version Pinning** - Add version specifications for tools
6. **Configuration Templates** - Allow custom configuration profiles
7. **Multi-language Support** - Add setup strings in multiple languages
8. **Validation Tests** - Add verification that tools are properly configured
9. **Performance Metrics** - Track installation times
10. **Update Mechanism** - Add upgrade scripts for existing installations

---

## 📚 Key Documentation References

- **Git Commit History** - Last 10 commits tracked in `.git/`
  - Most recent: Jules tool addition
  - Pattern: Incremental feature additions and bug fixes
  
- **Main README** - Comprehensive usage guide and overview
  
- **Inline Comments** - Minimal but functional within scripts

---

## 🛡️ Security & Safety Considerations

1. **User Isolation** - Configurations stored per-user in `$USER` directories
2. **Command Verification** - Always check if command exists before using
3. **Shell Injection Prevention** - Use quoted variables consistently
4. **Path Safety** - Use full paths with variable substitution
5. **Idempotent Operations** - Safe to re-run without side effects
6. **No Credentials** - Installation scripts don't store/require credentials
7. **Official Sources** - Uses official Homebrew and GitHub repositories

---

## 🎓 Learning Resources

### Understanding This Project

1. **Bash Patterns** - Study module sourcing and idempotent patterns
2. **Package Management** - See how Homebrew handles cross-platform installation
3. **Configuration as Code** - Learn NeoVim Lua-based configuration structure
4. **Shell Scripting Best Practices** - Error handling, color output, directory management
5. **Multi-language Development** - Setup patterns for JS, TS, Python, PHP, Terraform

---

## 📝 Summary for AI Tools

**Purpose**: Automated development environment provisioning
**Stack**: Bash, Homebrew, NeoVim, Node.js (FNM), Python (PyENV)
**Pattern**: Modular sourcing with idempotent setup/config functions
**Key Principle**: Non-destructive, reusable, cross-platform automation
**Target Users**: Developers who want automated, reproducible dev environments
**Main Components**: 
- Setup (installs binaries)
- Configuration (applies settings)
- Tools (tool-specific installers)
- Configs (NeoVim language-specific setup)

**When Helping With This Project**:
- Always maintain idempotency
- Test on both macOS and Linux
- Preserve existing user configurations
- Use established color and function naming patterns
- Follow the module sourcing pattern
- Document new features in README
- Keep tool scripts focused and under 50 lines when possible

