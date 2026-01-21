#!/bin/bash
set -e

# ==========================================
# Configuration and Paths
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo ">>> Starting installation setup..."
echo "    Root Config Dir: $ROOT_DIR"
echo "    Mac Settings Dir: $SCRIPT_DIR"

# ==========================================
# Homebrew Packages
# ==========================================

if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is not installed. Please install it first."
    exit 1
fi

echo ">>> Installing/Updating packages via Homebrew..."
brew update

PACKAGES=(
    "starship"
    "zoxide"
    "neovim"
    "fzf"
)

CASKS=(
    "wezterm"
)

echo "Installing packages: ${PACKAGES[*]}"
brew install "${PACKAGES[@]}"

echo "Installing casks: ${CASKS[*]}"
brew install --cask "${CASKS[@]}" || echo "WezTerm might already be installed via cask."

# ==========================================
# Oh My Zsh Setup
# ==========================================

echo ">>> Setting up Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ==========================================
# Plugins: zsh-autosuggestions
# ==========================================

echo ">>> Installing zsh-autosuggestions..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions already exists, pulling latest..."
    cd "$ZSH_CUSTOM/plugins/zsh-autosuggestions" && git pull && cd - > /dev/null
fi

# ==========================================
# Theme: Dracula
# ==========================================

echo ">>> Installing Dracula Zsh Theme..."
if [ ! -d "$ZSH_CUSTOM/themes/dracula" ]; then
    git clone https://github.com/dracula/zsh.git "$ZSH_CUSTOM/themes/dracula"
else
    echo "Dracula theme repo already exists, pulling latest..."
    cd "$ZSH_CUSTOM/themes/dracula" && git pull && cd - > /dev/null
fi

# Copy the theme file (using cp as requested, though symlink is common here, we stick to user preference for configs, applying to theme file for consistency)
echo "Copying dracula theme file..."
cp "$ZSH_CUSTOM/themes/dracula/dracula.zsh-theme" "$ZSH_CUSTOM/themes/dracula.zsh-theme"

# ==========================================
# Copy Configurations (cp instead of ln)
# ==========================================

backup_file() {
    if [ -f "$1" ]; then
        echo "Backing up $1 to $1.bak.$TIMESTAMP"
        cp "$1" "$1.bak.$TIMESTAMP"
    fi
}

echo ">>> Copying configuration files..."

# WezTerm
echo "Configuring WezTerm..."
backup_file "$HOME/.wezterm.lua"
cp "$ROOT_DIR/wezterm.lua" "$HOME/.wezterm.lua"

# Neovim
echo "Configuring Neovim..."
mkdir -p "$HOME/.config/nvim"
backup_file "$HOME/.config/nvim/init.lua"
cp "$ROOT_DIR/neovim.init.lua" "$HOME/.config/nvim/init.lua"

# Starship
echo "Configuring Starship..."
mkdir -p "$HOME/.config"
backup_file "$HOME/.config/starship.toml"
cp "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"

# .zshrc
echo "Configuring .zshrc..."
backup_file "$HOME/.zshrc"
cp "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"

echo ">>> Installation Complete!"
echo "    A new .zshrc has been created."
echo "    Please restart your terminal or run 'source ~/.zshrc' to apply changes."
