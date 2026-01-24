# Terminal Settings

开发环境配置方案 (Windows, Mac, Linux)。包含了 Alacritty, WezTerm, Neovim, Starship, Zsh/Fish 等工具的配置。

## Windows 配置方案

### 自动配置 (推荐)

此方案会自动下载便携版的工具到 `vendor/` 目录，并配置环境变量和软链接。

1. 打开 CMD 或 PowerShell。
2. 克隆此仓库（建议路径）：
   ```cmd
   git clone https://github.com/jwu/settings.git %USERPROFILE%\bin\settings
   ```
3. 进入 `win` 目录：
   ```cmd
   cd %USERPROFILE%\bin\settings\win
   ```
4. 运行更新脚本（自动下载 Alacritty, Starship, Nerd Fonts 等）：
   ```cmd
   install.bat
   ```
5. 运行配置脚本（生成配置文件链接）：
   ```cmd
   config.bat
   ```

### 手动配置

如果你更喜欢手动安装工具，请参考以下步骤：

1. **安装工具**:
   - [Alacritty](https://github.com/alacritty/alacritty/releases) 或 [WezTerm](https://wezterm.org/) (终端模拟器)
   - [Nerd Fonts (FiraMono)](https://www.nerdfonts.com/font-downloads) (推荐字体)
   - [Starship](https://starship.rs/) (终端提示符)
   - [Clink](https://github.com/chrisant996/clink) (增强 CMD 体验)
   - [Git for Windows](https://gitforwindows.org/)
   - [fzf](https://github.com/junegunn/fzf) (模糊搜索)
   - [fd](https://github.com/sharkdp/fd) (更快的 find)
   - [bat](https://github.com/sharkdp/bat) (更好的 cat)

2. **配置文件映射**:
   - **Alacritty**: 创建 `%APPDATA%\alacritty\alacritty.toml` 并引用 `win/alacritty.toml`。
   - **WezTerm**: 复制或链接 `common/wezterm.lua` 到 `%USERPROFILE%\.wezterm.lua`。
   - **LSD**: 复制或链接 `common/lsd.yaml` 到 `%APPDATA%\lsd\config.yaml`。
   - **Neovim**: 复制或链接 `common/neovim.init.lua` 到 `%LOCALAPPDATA%\nvim\init.lua`。
   - **Clink**: 配置 Clink 加载 `win/clink_scripts` 中的脚本。

---

## Mac 配置方案

### 自动配置 (推荐)

脚本会自动安装 Homebrew 包，配置 Oh My Zsh，并链接配置文件。

1. 打开终端。
2. 克隆此仓库：
   ```bash
   git clone https://github.com/jwu/settings.git ~/bin/settings
   ```
3. 运行安装脚本：
   ```bash
   cd ~/bin/settings/mac
   ./install.sh
   ```

### 手动配置

1. **安装 Homebrew** (如果尚未安装):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **安装软件包**:
   ```bash
   # 命令行工具
   brew install starship zoxide neovim fzf lsd fd bat
   # GUI 应用
   brew install --cask wezterm alacritty neovide zed
   ```

3. **配置 Shell (Zsh)**:
   - 安装 [Oh My Zsh](https://ohmyz.sh/)。
   - 安装插件 `zsh-autosuggestions`。
   - 参考或直接使用 `mac/zsh.zshrc` 的内容替换 `~/.zshrc`。

4. **复制/链接配置文件**:
   - `common/wezterm.lua` -> `~/.wezterm.lua`
   - `common/neovim.init.lua` -> `~/.config/nvim/init.lua`
   - `common/neovide.config.toml` -> `~/.config/neovide/config.toml`
   - `common/lsd.yaml` -> `~/.config/lsd/config.yaml`
   - `mac/starship.toml` -> `~/.config/starship.toml`
   - `mac/alacritty.toml` -> `~/.config/alacritty/alacritty.toml`

---

## Linux 配置方案

### 自动配置
*开发中 (WIP)...*

### 手动配置

1. **安装工具**:
   使用你的发行版包管理器 (apt, pacman, yum 等) 或参考官方文档安装：
   - `alacritty` 或 `wezterm` (终端模拟器)
   - `fish` (推荐 Shell), `starship`, `git`, `neovim`, `fzf`, `lsd`, `fd`, `bat`

2. **配置文件映射**:
   - **Fish Shell**: 编辑 `~/.config/fish/config.fish`，添加环境变量初始化。
   - **Alacritty**: 复制 `linux/alacritty.toml` 到 `~/.config/alacritty/alacritty.toml`。
   - **Starship**: 复制 `linux/starship.toml` 到 `~/.config/starship.toml`。
   - **Neovim**: 复制 `common/neovim.init.lua` 到 `~/.config/nvim/init.lua`。

## Neovim + NeoVide 手动安装手册

### Windows

1. 安装 [nvim](https://neovim.io/)
1. 安装 [neovide](https://neovide.dev/)
  1. 先运行一下
1. 复制 `init.lua` 到 `c:\Users\${YOUR_NAME}\AppData\Local\nvim\init.lua`
1. 复制 `config.toml` 到 `c:\Users\${YOUR_NAME}\AppData\Roaming\neovide\config.toml`
1. 安装 [lazy.nvim](https://github.com/folke/lazy.nvim)
1. 安装 [rg](https://github.com/BurntSushi/ripgrep)
1. 安装 `fonts`
1. 编译 `nvim-treesitter` parsers
  1. 阅读 [MSVC](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#msvc) session
  1. 安装 [Visual Studio Build Tools](https://visualstudio.microsoft.com/zh-hans/downloads/?q=build+tools+for+visual+studio)
  1. 打开 `x64 Native Tools Command Prompt`
  1. 打开 `neovide`
  1. 输入 `:TSUpdate`
  1. 等待安装结束

### Linux

1. 安装 [nvim](https://neovim.io/)
  1. `sudo cp -r nvim-linux64/bin/ /usr/`
  1. `sudo cp -r nvim-linux64/lib/ /usr/`
  1. `sudo cp -r nvim-linux64/share/ /usr/`
1. 安装 [neovide](https://neovide.dev/)
  1. `sudo cp neovide-linux-x86_64/neovide /usr/bin/`
  1. 更新 ubuntu desktop
    1. `sudo desktop-file-install neovide.desktop`
    1. `sudo update-desktop-database`
1. 复制 `init.lua` 到 `~/.config/nvim`
1. 复制 `config.toml` 到 `~/.config/neovide`
1. 安装 [lazy.nvim](https://github.com/folke/lazy.nvim)
1. 安装 [rg](https://github.com/BurntSushi/ripgrep)
1. 安装 `fonts`
1. 编译 `nvim-treesitter` parsers

---

## Reference

- Terminal
  - [WezTerm](https://wezterm.org/)
  - [alacritty](https://github.com/alacritty/alacritty)
  - [warp](https://www.warp.dev/)
  - Windows
    - [cmder](https://github.com/cmderdev/cmder)
    - [ConEmu](https://github.com/Maximus5/ConEmu)
    - [clink](https://github.com/chrisant996/clink)
      - [clink-completions](https://github.com/vladimir-kotikov/clink-completions)
      - [clink-fzf](https://github.com/chrisant996/clink-fzf)
      - [clink-zoxide](https://github.com/shunsambongi/clink-zoxide)
    - [git for windows](https://github.com/git-for-windows/git)
- Appearance
  - [nerdfonts](https://www.nerdfonts.com/)
  - [Dracula Theme](https://draculatheme.com/)
  - [starship](https://starship.rs/)
  - [zellij](https://zellij.dev/)
- Package Management
  - [uv](https://github.com/astral-sh/uv)
  - [bun](https://bun.com/)
  - [homebrew](https://brew.sh/)
- utils (awesome)
  - [rg](https://github.com/BurntSushi/ripgrep)
  - [z](https://github.com/ajeetdsouza/zoxide)
  - [fzf](https://github.com/junegunn/fzf)
    - [fd](https://github.com/sharkdp/fd)
    - [bat](https://github.com/sharkdp/bat)
  - [eza](https://github.com/eza-community/eza)
    - [lsd](https://github.com/Peltoche/lsd)
  - [procs](https://github.com/dalance/procs)
  - [btm](https://github.com/ClementTsang/bottom)
  - [dust](https://github.com/bootandy/dust)
  - [delta](https://github.com/dandavison/delta)
  - [sd](https://github.com/chmln/sd)
- utils (dev)
  - [opencode](https://opencode.ai/)
  - [mise](https://github.com/jdx/mise)
  - [xh](https://github.com/ducaale/xh)
  - [yq](https://github.com/mikefarah/yq)
    - [jq](https://github.com/stedolan/jq)
  - [sttr](https://github.com/abhimanyu003/sttr)
  - [grex](https://github.com/pemistahl/grex)
  - [hyperfine](https://github.com/sharkdp/hyperfine)
  - [navi](https://github.com/denisidoro/navi)
  - [yazi](https://github.com/sxyazi/yazi)
- utils (okay)
  - [xplr](https://github.com/sayanarijit/xplr)
  - [s](https://github.com/zquestz/s)
  - [deno](https://github.com/denoland/deno)
  - [glow](https://github.com/charmbracelet/glow)
- utils (needs package installer)
  - [fanyi](https://github.com/afc163/fanyi)
- utils (`*nix` only)
  - [sk](https://github.com/lotabout/skim)
- Shell
  - zsh
    - [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [nushell](https://github.com/nushell/nushell)
  - [fish](https://fishshell.com/)
