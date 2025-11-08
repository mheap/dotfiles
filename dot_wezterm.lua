-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font_with_fallback({
  "Hack Nerd Font Mono",
  "Apple Color Emoji", -- emoji support (macOS)
  "Noto Color Emoji",  -- emoji fallback (Linux)
  "Symbols Nerd Font", -- ensures all Nerd Font glyphs render
})

-- Make sure bold and italic variants are picked correctly
config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font_with_fallback({
      { family = "Hack Nerd Font Mono", weight = "Bold" },
      "Symbols Nerd Font",
    }),
  },
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font_with_fallback({
      { family = "Hack Nerd Font Mono", style = "Italic" },
      "Symbols Nerd Font",
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font_with_fallback({
      { family = "Hack Nerd Font Mono", weight = "Bold", style = "Italic" },
      "Symbols Nerd Font",
    }),
  },
}
config.color_scheme = 'nord'
config.font_size = 13.0

config.keys = {
  {
    key = "P",
    mods = "CMD|SHIFT",
    action = wezterm.action.ShowLauncher,
  },
  -- Cmd+Left: Activate previous tab
  {
    key = "LeftArrow",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  -- Cmd+Right: Activate next tab
  {
    key = "RightArrow",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(1),
  },
  -- Split horizontally (top/bottom)
  {
    key = 'L',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Move horizontally
  {
    key = 'RightArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right'
  },
  {
    key = 'LeftArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left'
  },
  -- Move vertically
  {
    key = 'DownArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down'
  },
  {
    key = 'UpArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up'
  },
  -- Split vertically (left/right)
  {
    key = 'J',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Zoom current pane
  {
    key = 'Return',
    mods = 'CMD|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- Close current pane
  {
    key = 'Backspace',
    mods = 'CMD|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

config.font_size = 30.0

config.quick_select_patterns = {
  -- match things that look like sha1 hashes
  -- (this is actually one of the default patterns)
  '[0-9a-f]{3,40}/',
}

-- Finally, return the configuration to wezterm:
return config
