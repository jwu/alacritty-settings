#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BIN_DIR="$HOME/.local/bin"

echo ">>> Starting x86_64 installation setup..."
echo "    Root Config Dir: $ROOT_DIR"
echo "    Mac Settings Dir: $SCRIPT_DIR"
echo "    Architecture: x86_64 (Intel)"

mkdir -p "$BIN_DIR"

ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
  echo "Warning: Detected arm64 (Apple Silicon). This script is optimized for x86_64 (Intel) Macs."
elif [ "$ARCH" = "x86_64" ]; then
  echo "    Architecture verified: x86_64"
else
  echo "Warning: Unknown architecture: $ARCH"
fi

download_and_install() {
  local url=$1
  local dest=$2
  local temp_dir=$(mktemp -d)
  local filename=$(basename "$url")

  echo "  Downloading $filename..."
  curl -fsSL "$url" -o "$temp_dir/$filename"
  tar -xzf "$temp_dir/$filename" -C "$temp_dir"
  mv "$temp_dir"/*/"$dest" "$BIN_DIR/$dest" 2>/dev/null || mv "$temp_dir/$dest" "$BIN_DIR/$dest"
  chmod +x "$BIN_DIR/$dest"

  rm -rf "$temp_dir"
  echo "  Installed: $dest"
}

echo ">>> Installing CLI tools via curl..."

if ! command -v starship &> /dev/null; then
  echo "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir "$BIN_DIR"
else
  echo "  starship already installed"
fi

if ! command -v zoxide &> /dev/null; then
  echo "Installing zoxide..."
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --bin-dir "$BIN_DIR"
else
  echo "  zoxide already installed"
fi

if ! command -v fzf &> /dev/null; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf
  /tmp/fzf/install --bin --no-update-rc --key-bindings --completion
  mv /tmp/fzf/bin/fzf "$BIN_DIR/fzf"
  rm -rf /tmp/fzf
else
  echo "  fzf already installed"
fi

if ! command -v lsd &> /dev/null; then
  echo "Installing lsd..."
  version="v1.2.0"
  url="https://github.com/lsd-rs/lsd/releases/download/${version}/lsd-${version}-x86_64-apple-darwin.tar.gz"
  download_and_install "$url" "lsd"
else
  echo "  lsd already installed"
fi

if ! command -v fd &> /dev/null; then
  echo "Installing fd..."
  version="10.2.0"
  url="https://github.com/sharkdp/fd/releases/download/v${version}/fd-v${version}-x86_64-apple-darwin.tar.gz"
  download_and_install "$url" "fd"
else
  echo "  fd already installed"
fi

if ! command -v bat &> /dev/null; then
  echo "Installing bat..."
  version="0.24.0"
  url="https://github.com/sharkdp/bat/releases/download/v${version}/bat-v${version}-x86_64-apple-darwin.tar.gz"
  download_and_install "$url" "bat"
else
  echo "  bat already installed"
fi

if ! command -v delta &> /dev/null; then
  echo "Installing delta..."
  version="0.18.2"
  url="https://github.com/dandavison/delta/releases/download/${version}/delta-${version}-x86_64-apple-darwin.tar.gz"
  download_and_install "$url" "delta"
else
  echo "  delta already installed"
fi

if ! command -v rg &> /dev/null; then
  echo "Installing ripgrep..."
  version="15.1.0"
  url="https://github.com/BurntSushi/ripgrep/releases/download/${version}/ripgrep-${version}-x86_64-apple-darwin.tar.gz"
  download_and_install "$url" "rg"
else
  echo "  ripgrep already installed"
fi

if ! command -v nvim &> /dev/null; then
  echo "Installing neovim..."
  version="v0.11.6"
  url="https://github.com/neovim/neovim/releases/download/${version}/nvim-macos-x86_64.tar.gz"
  temp_dir=$(mktemp -d)
  curl -fsSL "$url" -o "$temp_dir/nvim.tar.gz"
  tar -xzf "$temp_dir/nvim.tar.gz" -C "$temp_dir"
  cp "$temp_dir/nvim-macos-x86_64/bin/nvim" "$BIN_DIR/nvim"
  chmod +x "$BIN_DIR/nvim"
  [ ! -d "$HOME/.local/lib" ] && mkdir -p "$HOME/.local/lib"
  [ ! -d "$HOME/.local/share" ] && mkdir -p "$HOME/.local/share"
  cp -r "$temp_dir/nvim-macos-x86_64/lib/"* "$HOME/.local/lib/"
  cp -r "$temp_dir/nvim-macos-x86_64/share/"* "$HOME/.local/share/"
  rm -rf "$temp_dir"
else
  echo "  neovim already installed"
fi

export PATH="$BIN_DIR:$PATH"

echo ">>> Installing fonts..."

FONT_DIR="$HOME/Library/Fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/Fira Code Regular Nerd Font Complete.otf" ]; then
  echo "  Installing FiraCode Nerd Font..."
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.otf" -o "$FONT_DIR/Fira Code Regular Nerd Font Complete.otf"
else
  echo "  FiraCode Nerd Font already installed"
fi

echo ">>> Setting up Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "  Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo ">>> Installing zsh-autosuggestions..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  cd "$ZSH_CUSTOM/plugins/zsh-autosuggestions" && git pull && cd - > /dev/null
fi

echo ">>> Installing Dracula Zsh Theme..."
if [ ! -d "$ZSH_CUSTOM/themes/dracula" ]; then
  git clone https://github.com/dracula/zsh.git "$ZSH_CUSTOM/themes/dracula"
else
  cd "$ZSH_CUSTOM/themes/dracula" && git pull && cd - > /dev/null
fi

cp "$ZSH_CUSTOM/themes/dracula/dracula.zsh-theme" "$ZSH_CUSTOM/themes/dracula.zsh-theme"

backup_file() {
  if [ -f "$1" ]; then
    echo "  Backing up $1 to $1.bak.$TIMESTAMP"
    cp "$1" "$1.bak.$TIMESTAMP"
  fi
}

echo ">>> Copying configuration files..."

echo "Configuring WezTerm..."
backup_file "$HOME/.wezterm.lua"
cp "$ROOT_DIR/common/wezterm.lua" "$HOME/.wezterm.lua"

echo "Configuring LSD..."
mkdir -p "$HOME/.config/lsd"
backup_file "$HOME/.config/lsd/config.yaml"
cp "$ROOT_DIR/common/lsd.yaml" "$HOME/.config/lsd/config.yaml"

echo "Configuring Neovim..."
mkdir -p "$HOME/.config/nvim"
backup_file "$HOME/.config/nvim/init.lua"
cp "$ROOT_DIR/common/neovim.init.lua" "$HOME/.config/nvim/init.lua"

echo "Configuring Neovide..."
mkdir -p "$HOME/.config/neovide"
backup_file "$HOME/.config/neovide/config.toml"
cp "$ROOT_DIR/common/neovide.config.toml" "$HOME/.config/neovide/config.toml"

echo "Configuring Omnisharp..."
mkdir -p "$HOME/.omnisharp"
backup_file "$HOME/.omnisharp/omnisharp.json"
cp "$ROOT_DIR/common/omnisharp.json" "$HOME/.omnisharp/omnisharp.json"

echo "Configuring Starship..."
mkdir -p "$HOME/.config"
backup_file "$HOME/.config/starship.toml"
cp "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"

echo "Configuring .zshrc..."
backup_file "$HOME/.zshrc"
cp "$SCRIPT_DIR/zsh.zshrc" "$HOME/.zshrc"

echo "Configuring Git..."
mkdir -p "$HOME/.config/git"
backup_file "$HOME/.gitconfig"
cp "$ROOT_DIR/common/git.gitconfig" "$HOME/.gitconfig"

echo ""
echo ">>> x86_64 Installation Complete!"
echo ""
echo "    Make sure to add ~/.local/bin to your PATH:"
echo "      echo 'export PATH=\"~/.local/bin:\$PATH\"' >> ~/.zshrc"
echo ""
echo "    Installed CLI tools: starship, zoxide, neovim, fzf, lsd, fd, bat, delta, ripgrep"
echo "    Installed GUI apps: WezTerm, Neovide"
echo "    Installed fonts: FiraCode"
