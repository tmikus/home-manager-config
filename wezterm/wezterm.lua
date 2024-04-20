local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local font = wezterm.font('FiraCode Nerd Font')

config.color_scheme = 'Snazzy'
config.colors = {
  background = '#263238',
  scrollbar_thumb = '#009688',
  tab_bar = {
    active_tab = {
      bg_color = '#263238',
      fg_color = '#94a09e'
    },
    inactive_tab = {
      bg_color = '#1e272c',
      fg_color = '#ced0d6',
    },
    inactive_tab_hover = {
      bg_color = '#314549',
      fg_color = '#94a09e'
    },
    new_tab = {
      bg_color = '#1e272c',
      fg_color = '#94a09e'
    },
    new_tab_hover = {
      bg_color = '#30454d',
      fg_color = '#94a09e'
    }
  }
}
config.enable_scroll_bar = true
config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 14.0
config.send_composed_key_when_left_alt_is_pressed = true
config.use_fancy_tab_bar = true
config.use_ime = true
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_frame = {
  active_titlebar_bg = "#1e272c",
  font = font,
  font_size = 13.0,
  inactive_titlebar_bg = "#1e272c"
}

return config
