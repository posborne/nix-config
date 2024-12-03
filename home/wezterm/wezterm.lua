local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'CaskaydiaCove Nerd Font'
config.font_size = 14.0
config.color_scheme = 'Palenight (Gogh)'

-- workaround for weird rendering issues due to some unresolved
-- issues with nix/wezterm that neither has figured out yet.
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

return config
