-- Pull in the wezterm API
local wezterm = require 'wezterm'
local theme = require 'wezterm-theme'

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return "Terminal"
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

theme.apply_to_config(config)

-- This is where you actually apply your config choices
config.default_prog = { 'C:/msys64/msys2_shell.cmd', '-defterm', '-here', '-no-start', '-ucrt64', '-full-path', '-shell', 'zsh' }

config.window_decorations = 'RESIZE'
config.window_close_confirmation = 'NeverPrompt'
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
