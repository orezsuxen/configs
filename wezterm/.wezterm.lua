--
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
-- config.color_scheme = 'OneDark (base16)'
-- config.color_scheme = "OneDark (Gogh)"
-- config.color_scheme = 'Tokyo Night'
-- config.color_scheme = "nord"
config.color_scheme = "Neutron (Gogh)"
--
-- config.font = wezterm.font 'JetBrains Mono'
config.font = wezterm.font("FiraCode Nerd Font")
--config.font_size = 12.0 --default is 12.0

-- === TAB BAR ===
-- config.enable_tab_bar
config.use_fancy_tab_bar = false --default true
-- config.hide_tab_bar_if_only_one_tab
config.tab_bar_at_bottom = true
--config.tab_max_width = 15 -- measuered in cells only when tab bar in retro mode
--
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- config.window_background_image = '/path/to/wallpaper.jpg'
-- config.window_background_image_hsb = {
-- Darken the background image by reducing it to 1/3rd
-- brightness = 0.005,

-- You can adjust the hue by scaling its value.
-- a multiplier of 1.0 leaves the value unchanged.
-- hue = 1.0,

-- You can adjust the saturation also.
-- saturation = 1.0,
-- }

-- === Default PROG ===
-- for windows
config.default_prog = { "/Program Files/PowerShell/7/pwsh.exe", "-NoLogo" }

-- and finally, return the configuration to wezterm
return config
