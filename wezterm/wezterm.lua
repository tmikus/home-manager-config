local wezterm = require 'wezterm'

local default_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if pane:is_alt_screen_active() then
    overrides.enable_scroll_bar = false
    overrides.window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
    }
  else
    overrides.enable_scroll_bar = true
    overrides.window_padding = default_padding
  end
  window:set_config_overrides(overrides)
end)

local function is_windows()
  return package.config:sub(1, 1) == "\\" and true or false
end

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
config.font_size = is_windows() and 11.0 or 14.0
config.send_composed_key_when_left_alt_is_pressed = true
config.use_fancy_tab_bar = true
config.use_ime = true
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_frame = {
  active_titlebar_bg = "#1e272c",
  font = font,
  font_size = is_windows() and 10.0 or 13.0,
  inactive_titlebar_bg = "#1e272c"
}
config.window_padding = default_padding

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function get_home_path()
  local home = os.getenv("HOME")
  if home then
    return home
  end
  return os.getenv("userprofile")
end

local additional_config_path = get_home_path() .. '/wezterm-local'

if file_exists(additional_config_path .. '.lua') then
  local overrides = require(additional_config_path)
  for k, v in pairs(overrides) do config[k] = v end
end

return config
