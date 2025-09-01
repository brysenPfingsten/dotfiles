local wezterm = require 'wezterm'

return {
  color_scheme = "Gruvbox Dark",
  font = wezterm.font("FiraCode Nerd Font", { weight = "Regular" }),
  font_size = 13.0,
  window_background_opacity = 0.9,
  text_background_opacity = 1.0,
  enable_tab_bar = true,
    keys = {
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
    { key = "Enter", mods = "CTRL|SHIFT", action = "ToggleFullScreen" },
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  },
  enable_kitty_graphics = true,

  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },

  scrollback_lines = 5000,
}
