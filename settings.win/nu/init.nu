source ~\AppData\Roaming\nushell\config.nu
source ~\AppData\Roaming\nushell\env.nu

let-env config = {
  show_banner: false
}

let-env STARSHIP_CONFIG = 'e:\Alacritty\settings\starship.toml'

source e:\Alacritty\settings\nu\starship.nu
source e:\Alacritty\settings\nu\zoxide.nu
