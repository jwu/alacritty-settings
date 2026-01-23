local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local default_cwd = '~'
local font_size = 16.5
local mod_key = 'CMD'
local mod_key_2 = 'CMD|SHIFT'
local font_en = 'FiraMono Nerd Font'
local font_zh = 'PingFang SC'

if wezterm.target_triple:find("windows") then
  default_cwd = 'c:\\bin'
  font_size = 12.5
  mod_key = 'CTRL'
  mod_key_2 = 'CTRL|SHIFT'
  font_zh = 'Microsoft YaHei'
end

config.default_cwd = default_cwd
config.set_environment_variables = {
  TERM = 'wezterm',
}

-- Appearance
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
-- config.tab_max_width = 16

-- Colors
config.color_scheme = 'Dracula'
config.window_frame = {
  active_titlebar_bg = '#222222',
  inactive_titlebar_bg = '#222222',
}
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#2b2042',
      fg_color = '#c0c0c0',
      intensity = 'Normal',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },
  }
}

----------------------------------------------------------------------
-- General
----------------------------------------------------------------------

config.automatically_reload_config = true
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.window_close_confirmation = 'NeverPrompt'
config.front_end = "WebGpu"
config.bold_brightens_ansi_colors = true

----------------------------------------------------------------------
-- Window
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
-- Font
----------------------------------------------------------------------

config.font_size = font_size
config.freetype_load_target = "Light"
config.freetype_render_target = "Light"
config.freetype_load_flags = "NO_HINTING"

config.font = wezterm.font_with_fallback({
  {
    family = font_en,
    weight = 'Medium',
  },
  {
    family = font_zh,
    weight = 'Medium'
  },
})

config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font({
      family = font_en,
      weight = 'Bold',
    }),
  },
  {
    italic = true,
    font = wezterm.font({
      family = font_en,
      style = 'Italic',
    }),
  },
  {
    italic = true,
    intensity = 'Bold',
    font = wezterm.font({
      family = font_en,
      weight = 'Bold',
      style = 'Italic',
    }),
  },
}

----------------------------------------------------------------------
-- Cursor
----------------------------------------------------------------------

config.cursor_blink_rate = 750
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseOut'
config.default_cursor_style = 'BlinkingBlock'

----------------------------------------------------------------------
-- Scroll
----------------------------------------------------------------------

config.scrollback_lines = 10000
config.mouse_wheel_scrolls_tabs = false

----------------------------------------------------------------------
-- Mouse
----------------------------------------------------------------------

config.hide_mouse_cursor_when_typing = false

----------------------------------------------------------------------
-- Selection
----------------------------------------------------------------------

config.selection_word_boundary = '{}[]()"\'`.,;:'

----------------------------------------------------------------------
-- Bell
----------------------------------------------------------------------

config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseOut',
  fade_out_function = 'EaseOut',
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
}

----------------------------------------------------------------------
-- Key Bindings
----------------------------------------------------------------------

config.keys = {
  -- new & close
  {
    key = 't',
    mods = mod_key,
    action = wezterm.action.SpawnTab('CurrentPaneDomain'),
  },
  {
    key = 'n',
    mods = mod_key,
    action = wezterm.action.SpawnWindow,
  },
  {
    key = 'w',
    mods = mod_key,
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  -- {
  --   key = 'Enter',
  --   mods = 'CTRL',
  --   action = wezterm.action.TogglePaneZoomState,
  -- },

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
    mods = mod_key_2,
    action = wezterm.action.SplitPane {
      direction = 'Left',
      size = { Percent = 50 },
    },
  },
  {
    key = 'RightArrow',
    mods = mod_key_2,
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = 'UpArrow',
    mods = mod_key_2,
    action = wezterm.action.SplitPane {
      direction = 'Up',
      size = { Percent = 50 },
    },
  },
  {
    key = 'DownArrow',
    mods = mod_key_2,
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
}

----------------------------------------------------------------------

return config
