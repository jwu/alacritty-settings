# AGENTS.md - Terminal Settings Repository Guidelines

This repository contains terminal configuration files and installation scripts for Windows, macOS, and Linux.

## Build/Lint/Test Commands

This is a configuration repository with shell/batch scripts. There is no traditional build system.

### Running Installation Scripts

**macOS:**
```bash
cd mac
./install.sh              # Install and configure terminal tools
./setup_dev.sh           # Set up development environment (Rust, uv, Bun, NVM)
```

**Windows:**
```cmd
cd win
install.bat              # Download and install tools
config.bat               # Create symlinks for configurations
```

**Linux:**
```bash
# Manual setup - scripts are WIP
# Install tools via package manager, then copy/link configs from common/
```

### Validating Scripts

**ShellCheck (Bash):**
```bash
# Install shellcheck
brew install shellcheck  # macOS
apt install shellcheck   # Linux

# Check a script
shellcheck mac/install.sh

# Check all scripts
find . -name "*.sh" -exec shellcheck {} \;
```

**BatchLint (Windows Batch):**
```powershell
# Install via pip
pip install batchlint

# Check a batch file
batchlint win/install.bat
```

### Syntax Validation

**Bash dry-run:**
```bash
bash -n script.sh  # Parse-only, check syntax
```

**Batch file check:**
```cmd
# Windows built-in
call :label  # Test goto targets exist
```

## Code Style Guidelines

### Shell Scripts (Bash)

**Indentation:** Use 2 spaces for indentation (no tabs).

**Shebang and Error Handling:**
```bash
#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures
```

**Variable Naming:**
- Use `SCREAMING_SNAKE_CASE` for constants
- Use `camelCase` or `snake_case` for local variables
- Double-quote all variable expansions: `"$VAR"` not `$VAR`

**Path Handling:**
```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
```

**Output Format:**
```bash
echo ">>> Starting installation..."
echo "    Informational message"
echo "Error: Something failed" >&2
exit 1
```

**Arrays for Lists:**
```bash
PACKAGES=(
    "starship"
    "zoxide"
    "neovim"
)

brew install "${PACKAGES[@]}"
```

**Command Existence Check:**
```bash
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is not installed."
    exit 1
fi
```

**Optional Operations:**
```bash
brew tap homebrew/cask-fonts 2>/dev/null || true
```

### Batch Scripts (Windows)

**Header:**
```batch
@echo off
setlocal enabledelayedexpansion
```

**Variables:**
```batch
set "VAR_NAME=value"
set "PATH_DIR=%USERPROFILE%\bin"
```

**Functions:**
```batch
:UPDATE_ALACRITTY
echo "Updating Alacritty..."
goto:eof
```

**Error Handling:**
```batch
set "ERROR_COUNT=0"

:DOWNLOAD_FILE
curl "%URL%" -L -o "%OUTPUT%" || (
    echo Failed to download
    set /a "ERROR_COUNT+=1"
    exit /b 1
)
```

### Configuration Files

**TOML (.toml):**
- Alacritty, Neovide configs
- Standard TOML format with `key = value`

**Lua (.lua):**
- Neovim init, WezTerm config
- Lua 5.1+ compatible
- Use `local` for module-scoped variables

**YAML (.yaml):**
- LSD config
- Standard YAML 1.2

**JSON (.json):**
- Zed, Omnisharp configs
- Standard JSON (no comments)

### Import/Link Strategy

**macOS/Linux - Symlinks Preferred:**
```bash
ln -sf "$ROOT_DIR/common/wezterm.lua" "$HOME/.wezterm.lua"
```

**Windows - Copy or mklink:**
```batch
copy "%~dp0\..\common\wezterm.lua" "%USERPROFILE%\.wezterm.lua"
```

**Backup Before Modification:**
```bash
backup_file() {
    if [ -f "$1" ]; then
        cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
    fi
}
```

### Error Handling Patterns

**Bash:**
```bash
# Exit on failure
if ! command_that_might_fail; then
    echo "Error: ..." >&2
    exit 1
fi

# Or use &&/||
command_that_might_fail || exit 1
```

**Batch:**
```batch
set "ERROR_COUNT=0"

:PROCESS
command || (
    echo Failed
    set /a "ERROR_COUNT+=1
)
```

### General Conventions

1. **Version Constants:** Define at top of scripts
2. **Modular Functions:** Use labeled sections in batch, functions in bash
3. **Silent Optional Operations:** Use `|| true` or `2>/dev/null`
4. **Clear Output:** Use `>>>` prefix for major steps
5. **Cross-Platform Paths:** Use `$HOME`, `%USERPROFILE%`, not hardcoded paths
6. **No Secrets:** Never commit API keys, tokens, or passwords
7. **Idempotent Scripts:** Safe to run multiple times

### Directory Structure

```
settings/
├── common/              # Shared configs (wezterm.lua, lsd.yaml, neovim.init.lua)
├── mac/                 # macOS-specific (install.sh, setup_dev.sh, alacritty.toml)
├── win/                 # Windows-specific (install.bat, config.bat)
├── linux/               # Linux-specific (WIP)
└── AGENTS.md           # This file
```

## Cursor/Copilot Rules

No specific Cursor rules or Copilot instructions found in the repository.

## Notes for Agents

- This is a dotfiles/config repository, not an application
- Changes to scripts should be tested on the target platform
- Configuration file changes should maintain compatibility with existing setups
- When adding new tools, update version constants in both mac/*.sh and win/*.bat
- Respect user choice of symlinks vs copies as documented in scripts
