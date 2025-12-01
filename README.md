# Alacritty Settings

<img src="./imgs/preview.png" style="width:600px;"/>

## Features

<div style="position: relative; width:600px;">
  <img src="./imgs/fast_cd.gif"/>
  <p style="position: absolute; bottom: 10px; right: 10px; color: white;">Fast access directory</p>
</div>

<div style="position: relative; width:600px;">
  <img src="./imgs/fzf_search.gif"/>
  <p style="position: absolute; bottom: 10px; right: 10px; color: white;">Fuzz search files</p>
</div>

<div style="position: relative; width:600px;">
  <img src="./imgs/git_complete.gif"/>
  <p style="position: absolute; bottom: 10px; right: 10px; color: white;">Command completions</p>
</div>

## Install (quick)

**Windows Setup**

1. clone the repo
1. Run `update.bat`
1. Run `config-alacritty.bat`

FLY!!

**Mac/Linux Setup**

WIP...

## Install (manually)

**Windows Setup**

1. `git clone git@github.com:jwu/alacritty-settings.git ${YOUR_ALACRITTY_PATH}`
1. install [alacritty](https://github.com/alacritty/alacritty/releases) to `${YOUR_ALACRITTY_PATH}`
1. install [FiraMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraMono.zip)
1. unzip [clink](https://github.com/chrisant996/clink/releases) to `${YOUR_ALACRITTY_PATH}/vendor/clink`
1. unzip [clink-completions](https://github.com/vladimir-kotikov/clink-completions/releases) to `${YOUR_ALACRITTY_PATH}/vendor/clink_completions`
1. unzip [git-for-windows](https://github.com/git-for-windows/git/releases) to `${YOUR_ALACRITTY_PATH}/vendor/git`
1. unzip [starship](https://github.com/starship/starship/releases) to `${YOUR_ALACRITTY_PATH}/vendor`
1. unzip [fzf](https://github.com/junegunn/fzf/releases) to `${YOUR_ALACRITTY_PATH}/vendor/bin`
1. unzip [zoxide](https://github.com/ajeetdsouza/zoxide/releases) to `${YOUR_ALACRITTY_PATH}/vendor/bin`
1. Run `config-alacritty.bat`

**Mac & Linux Setup**

1. `git clone git@github.com:jwu/alacritty-settings.git ${YOUR_ALACRITTY_PATH}`
1. install [alacritty](https://github.com/alacritty/alacritty/releases) to `${YOUR_ALACRITTY_PATH}`
1. install [FiraMono Nerd Font](https://www.nerdfonts.com/font-downloads)
1. install [fishshell](https://fishshell.com/)
1. install [git](https://git-scm.com/)
1. install starship `curl -sS https://starship.rs/install.sh | sh`
1. install fzf `sudo apt install fzf`
1. install zellij `cargo install --locked zellij`
1. cp `settings.linux/alacrity.toml` to `~/.alacritty.toml`
1. cp `settings.linux/starship.toml` to `~/.config/starship.toml`
1. cp `settings.linux/config.kdl` to `~/.config/zellij/config.kdl`
1. edit `~/.config/fish/config.fish`

**~/.config/fish/config.fish**

```fish
set -x PATH ~/bin ~/.cargo/bin ~/.local/bin /usr/local/bin $PATH
set -x PATH /opt/nvim-linux64/bin $PATH
set -x LANG "en_US.UTF-8"

# NOTE: in ubuntu, this doesn't work
# set -x STARSHIP_CONFIG "~/alacritty-settings/settings.mac/starship.toml"

starship init fish | source
zoxide init fish | source
```

## Reference

- [alacritty](https://github.com/alacritty/alacritty)
  - [alacritty dracula-color-theme](https://github.com/dracula/alacritty)
  - [nerdfonts](https://www.nerdfonts.com/)
- vendor
  - [clink](https://github.com/chrisant996/clink)
    - [clink-completions](https://github.com/vladimir-kotikov/clink-completions)
    - [clink-fzf](https://github.com/chrisant996/clink-fzf)
    - [clink-zoxide](https://github.com/shunsambongi/clink-zoxide)
  - [starship](https://github.com/starship/starship)
  - [git](https://github.com/git-for-windows/git)
- utils (awesome)
  - [rg](https://github.com/BurntSushi/ripgrep)
  - [z](https://github.com/ajeetdsouza/zoxide)
  - [fzf](https://github.com/junegunn/fzf)
    - [fd](https://github.com/sharkdp/fd)
  - [eza](https://github.com/eza-community/eza)
    - [lsd](https://github.com/Peltoche/lsd)
  - [bat](https://github.com/sharkdp/bat)
  - [procs](https://github.com/dalance/procs)
  - [btm](https://github.com/ClementTsang/bottom)
  - [dust](https://github.com/bootandy/dust)
  - [delta](https://github.com/dandavison/delta)
  - [sd](https://github.com/chmln/sd)
- utils (dev)
  - [mise](https://github.com/jdx/mise)
  - [xh](https://github.com/ducaale/xh)
  - [yq](https://github.com/mikefarah/yq)
    - [jq](https://github.com/stedolan/jq)
  - [sttr](https://github.com/abhimanyu003/sttr)
  - [grex](https://github.com/pemistahl/grex)
  - [hyperfine](https://github.com/sharkdp/hyperfine)
  - [navi](https://github.com/denisidoro/navi)
- utils (okay)
  - [xplr](https://github.com/sayanarijit/xplr)
  - [s](https://github.com/zquestz/s)
  - [deno](https://github.com/denoland/deno)
  - [glow](https://github.com/charmbracelet/glow)
- utils (needs package installer)
  - [fanyi](https://github.com/afc163/fanyi)
- utils (`*nix` only)
  - [sk](https://github.com/lotabout/skim)
- others
  - [nushell](https://github.com/nushell/nushell)
  - Mac
    - [warp](https://www.warp.dev/)
  - Mac, BSD & `*nix`
    - [fish](https://fishshell.com/)
    - [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [zellij](https://zellij.dev/)
  - Windows
    - [WezTerm](https://wezterm.org/)
    - [cmder](https://github.com/cmderdev/cmder)
    - [ConEmu](https://github.com/Maximus5/ConEmu)

## Some helpful configs or commands

### set default shell on `*nix` platofrom

```shell
# set zsh as default shell
sudo chsh -s /bin/zsh

# set fish as default shell
sudo chsh -s /usr/local/bin/fish
```

### ~/.alacritty.yml

```yml
import:
  - e:\Alacritty\settings\alacritty.yml

shell:
  program: cmd.exe
  args:
    - /s /k "e:\Alacritty\settings\init.bat"
```

### ~/.zshrc

```zsh
export PATH=~/bin:/usr/local/bin:$PATH
export ZSH=~/.oh-my-zsh
export LANG=en_US.UTF-8
export STARSHIP_CONFIG=~/alacritty-settings/settings.mac/starship.toml

ZSH_THEME="dracula"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
```

### ~/.config/fish/config.fish

```fish
set -x PATH ~/bin ~/.cargo/bin ~/.local/bin /usr/local/bin $PATH
set -x PATH /opt/nvim-linux64/bin $PATH
set -x LANG "en_US.UTF-8"

# NOTE: in ubuntu, this doesn't work
# set -x STARSHIP_CONFIG "~/alacritty-settings/settings.mac/starship.toml"

starship init fish | source
zoxide init fish | source
```
