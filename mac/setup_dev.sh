#!/bin/bash
set -e

echo ">>> Starting Development Environment Setup for Mac..."

# 1. Xcode Command Line Tools
echo ">>> Checking Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "--------------------------------------------------------"
    echo "NOTE: An installation dialog should have appeared."
    echo "Please complete the installation before proceeding."
    echo "--------------------------------------------------------"
    read -p "Press Enter once Xcode CLI tools installation is complete..."
else
    echo "Xcode Command Line Tools already installed."
fi

# 2. Git (Usually comes with Xcode CLI or Homebrew)
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install git
    else
        echo "Error: Brew not found. Please run install.sh first or install Homebrew manually."
        exit 1
    fi
fi

# 3. Rust (rustup)
echo ">>> Installing/Updating Rust..."
if command -v rustup &> /dev/null; then
    echo "Rust already installed. Updating..."
    rustup update
else
    echo "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# 4. uv (Python tool)
echo ">>> Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# 5. Bun
echo ">>> Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# 6. Node.js via NVM
echo ">>> Installing NVM and Node.js LTS..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    # Install NVM (using v0.39.7 as a stable baseline, check for latest if needed)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # Load NVM for this session to install node
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    echo "NVM already installed."
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

echo "Installing Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

echo ">>> Development Setup Complete!"
echo "    Please restart your terminal or source your shell config."
