# Alacritty Settings

<img src="./imgs/preview.png" alt="preview" style="width:600px;"/>

## Features

<div style="position: relative; width:600px;">
  <img src="./imgs/fast_cd.gif" alt="preview"/>
  <p style="position: absolute; bottom: 10px; right: 10px; color: white;">Fast access directory</p>
</div>

<div style="position: relative; width:600px;">
  <img src="./imgs/fzf_search.gif" alt="preview"/>
  <p style="position: absolute; bottom: 10px; right: 10px; color: white;">Fuzz search files</p>
</div>

<div style="position: relative; width:600px;">
  <img src="./imgs/git_complete.gif" alt="preview"/>
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
1. copy `${YOUR_ALACRITTY_PATH}/alacrity.default.yml` to `~/AppData/Roaming/alacritty/alacritty.yml`
1. unzip [clink](https://github.com/chrisant996/clink/releases) to `${YOUR_ALACRITTY_PATH}/vendor/clink`
1. unzip [clink-completions](https://github.com/vladimir-kotikov/clink-completions/releases) to `${YOUR_ALACRITTY_PATH}/vendor/clink_completions`
1. unzip [git-for-windows](https://github.com/git-for-windows/git/releases) to `${YOUR_ALACRITTY_PATH}/vendor/git`
1. unzip [starship](https://github.com/starship/starship/releases) to `${YOUR_ALACRITTY_PATH}/vendor`
1. unzip [fzf](https://github.com/junegunn/fzf/releases) to `${YOUR_ALACRITTY_PATH}/vendor/bin`
1. unzip [zoxide](https://github.com/ajeetdsouza/zoxide/releases) to `${YOUR_ALACRITTY_PATH}/vendor/bin`

**Mac/Linux Setup**

WIP...

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
- utils
  - [z](https://github.com/ajeetdsouza/zoxide)
  - [fzf](https://github.com/junegunn/fzf)
  - [fd](https://github.com/sharkdp/fd)
  - [bat](https://github.com/sharkdp/bat)
  - [s](https://github.com/zquestz/s)
  - [hyperfine](https://github.com/sharkdp/hyperfine)
  - [lsd](https://github.com/Peltoche/lsd)
  - [procs](https://github.com/dalance/procs)
  - [rg](https://github.com/BurntSushi/ripgrep)
  - [btm](https://github.com/ClementTsang/bottom)
  - [grex](https://github.com/pemistahl/grex)
  - [delta](https://github.com/dandavison/delta)
  - [dust](https://github.com/bootandy/dust)
  - [navi](https://github.com/denisidoro/navi)
  - [glow](https://github.com/charmbracelet/glow)
- others
  - [warp](https://www.warp.dev/)
  - [nushell](https://github.com/nushell/nushell)
  - [cmder](https://github.com/cmderdev/cmder)
  - [ConEmu](https://github.com/Maximus5/ConEmu)
  - [zellij](https://zellij.dev/)

## Some helpful configs

### alacritty.yml

```yml
import:
  - e:\Alacritty\settings\alacritty.yml

shell:
  program: cmd.exe
  args:
    - /s /k "e:\Alacritty\settings\init.bat"
```
