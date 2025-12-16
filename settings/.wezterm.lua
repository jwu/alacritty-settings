local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- 启动的 shell（等价于 terminal.shell）
config.default_prog = {
  'cmd.exe',
  '/s',
  '/k',
  'D:\\alacritty\\settings\\init.bat',
}

config.default_cwd = 'D:\\'
config.enable_tab_bar = true

----------------------------------------------------------------------
-- 基本行为
----------------------------------------------------------------------

config.automatically_reload_config = true
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.window_close_confirmation = 'NeverPrompt'

----------------------------------------------------------------------
-- 窗口设置
----------------------------------------------------------------------

config.window_decorations = 'RESIZE' -- Alacritty 的 full
config.window_background_opacity = 0.95
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.adjust_window_size_when_changing_font_size = false
config.initial_cols = nil
config.initial_rows = nil

----------------------------------------------------------------------
-- 字体
----------------------------------------------------------------------

config.font_size = 12.5
config.freetype_load_target = "Light"
config.freetype_render_target = "Light"
config.freetype_load_flags = "NO_HINTING"

config.font = wezterm.font_with_fallback({
  {
    family = 'FiraMono Nerd Font',
    weight = 'Regular',
  },
})

config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font({
      family = 'FiraMono Nerd Font',
      weight = 'Bold',
    }),
  },
  {
    italic = true,
    font = wezterm.font({
      family = 'FiraMono Nerd Font',
      style = 'Italic',
    }),
  },
  {
    italic = true,
    intensity = 'Bold',
    font = wezterm.font({
      family = 'FiraMono Nerd Font',
      weight = 'Bold',
      style = 'Italic',
    }),
  },
}

----------------------------------------------------------------------
-- 光标
----------------------------------------------------------------------

config.cursor_blink_rate = 750
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseOut'
config.default_cursor_style = 'BlinkingBlock'

----------------------------------------------------------------------
-- 滚动
----------------------------------------------------------------------

config.scrollback_lines = 10000
config.mouse_wheel_scrolls_tabs = false

----------------------------------------------------------------------
-- 鼠标
----------------------------------------------------------------------

config.hide_mouse_cursor_when_typing = false

----------------------------------------------------------------------
-- 选择
----------------------------------------------------------------------

config.selection_word_boundary = '{}[]()"\'`.,;:'

-- 等价于 save_to_clipboard = true
-- config.selection_clipboard = 'Clipboard'

----------------------------------------------------------------------
-- 颜色（Dracula 风格，来自你的 alacritty 配置）
----------------------------------------------------------------------

config.colors = {
  foreground = '#f8f8f2',
  background = '#282a36',
  cursor_bg = '#f8f8f2',
  cursor_fg = '#282a36',
  cursor_border = '#f8f8f2',
  -- selection_fg = '#f8f8f2',
  selection_bg = '#44475a',

  ansi = {
    '#21222c', -- black
    '#ff5555', -- red
    '#50fa7b', -- green
    '#f1fa8c', -- yellow
    '#bd93f9', -- blue
    '#ff79c6', -- magenta
    '#8be9fd', -- cyan
    '#f8f8f2', -- white
  },

  brights = {
    '#6272a4',
    '#ff6e6e',
    '#69ff94',
    '#ffffa5',
    '#d6acff',
    '#ff92df',
    '#a4ffff',
    '#ffffff',
  },

  tab_bar = {
    background = '#282a36',
    active_tab = {
      bg_color = '#44475a',
      fg_color = '#f8f8f2',
    },
    inactive_tab = {
      bg_color = '#282a36',
      fg_color = '#6272a4',
    },
    inactive_tab_hover = {
      bg_color = '#44475a',
      fg_color = '#f8f8f2',
    },
  },
}

----------------------------------------------------------------------
-- Bell（Alacritty bell.duration = 0 → WezTerm 关闭视觉 bell）
----------------------------------------------------------------------

config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseOut',
  fade_out_function = 'EaseOut',
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
}

----------------------------------------------------------------------
-- 快捷键
----------------------------------------------------------------------

config.keys = {
  {
    key = 'n',
    mods = 'CTRL',
    action = wezterm.action.SpawnWindow,
  },

  -- active pane
  {
    key = 'LeftArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },

  -- split pane
  {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Left',
      size = { Percent = 50 },
    },
  },
  {
    key = 'RightArrow',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = 'UpArrow',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Up',
      size = { Percent = 50 },
    },
  },
  {
    key = 'DownArrow',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
}

----------------------------------------------------------------------
-- 标题
----------------------------------------------------------------------

config.window_frame = {
  active_titlebar_bg = '#282a36',
  inactive_titlebar_bg = '#282a36',
}

config.set_environment_variables = {
  TERM = 'wezterm',
}

----------------------------------------------------------------------

return config
