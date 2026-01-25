-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Functions

local project_dir = wezterm.home_dir .. "/development"

local function project_dirs()
  -- Start with your home directory as a project, 'cause you might want
  -- to jump straight to it sometimes.
  local projects = {}

  local all_projects = wezterm.glob(project_dir .. '/kong/*')

  for _, v in pairs(wezterm.glob(project_dir .. '/oss/*')) do table.insert(all_projects, v) end


  -- WezTerm comes with a glob function! Let's use it to get a lua table
  -- containing all subdirectories of your project folder.
  for _, dir in ipairs(all_projects) do
    -- ... and add them to the projects table.

    -- Filter to just the common ones
    local matches = {
      "platform-api", "admin-spec-generator", "developer.konghq.com",
      "michaelheap.com"
    }
    for _, value in ipairs(matches) do
      if dir:find(value, 1, true) then
        table.insert(projects, dir)
      end
    end
  end

  return projects
end

function choose_project()
  local choices = { { label = "default" } }
  for _, value in ipairs(project_dirs()) do
    table.insert(choices, { label = value })
  end

  return wezterm.action.InputSelector {
    title = "Projects",
    choices = choices,
    fuzzy = true,
    action = wezterm.action_callback(function(child_window, child_pane, id, label)
      -- "label" may be empty if nothing was selected. Don't bother doing anything
      -- when that happens.
      if not label then return end

      if label == "default" then
        child_window:perform_action(wezterm.action.SwitchToWorkspace {
          name = "default"
        }, child_pane)
        return
      end

      -- The SwitchToWorkspace action will switch us to a workspace if it already exists,
      -- otherwise it will create it for us.
      child_window:perform_action(wezterm.action.SwitchToWorkspace {
        name = label:match("([^/]+)$"),
        spawn = { cwd = label },
      }, child_pane)
    end),
  }
end

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

config.leader = { key = ',', mods = 'CMD', timeout_milliseconds = 10000 }

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

  -- Move horizontally
  {
    key = 'l',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right'
  },
  {
    key = 'h',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left'
  },
  -- Move vertically
  {
    key = 'j',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down'
  },
  {
    key = 'k',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up'
  },

  -- Zoom current pane
  {
    key = 'Return',
    mods = 'CMD|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },


  {
    key = 'p',
    mods = 'CMD|SHIFT',
    -- Present in to our project picker
    action = choose_project(),
  },

  {
    -- Enter split mode
    key = 's',
    mods = 'LEADER',
    -- Activate the `resize_panes` keytable
    action = wezterm.action.ActivateKeyTable {
      name = 'split_panes',
      one_shot = true,
      -- Deactivate the keytable after a timeout.
      timeout_milliseconds = 100000,
    }
  },

  {
    -- Enter resize mode
    key = 'r',
    mods = 'LEADER',
    -- Activate the `resize_panes` keytable
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      -- Ensures the keytable stays active after it handles its
      -- first keypress.
      one_shot = false,
      -- Deactivate the keytable after a timeout.
      timeout_milliseconds = 1000,
    }
  },
}

local function resize_pane(key, direction)
  return {
    key = key,
    action = wezterm.action.AdjustPaneSize { direction, 3 }
  }
end

config.key_tables = {
  resize_panes = {
    resize_pane('j', 'Down'),
    resize_pane('k', 'Up'),
    resize_pane('h', 'Left'),
    resize_pane('l', 'Right'),
  },
  split_panes = {
    -- Split vertically (left/right)
    {
      key = 'j',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- Split horizontally (top/bottom)
    {
      key = 'l',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    -- Close current pane
    {
      key = 'Backspace',
      action = wezterm.action.CloseCurrentPane { confirm = false },
    },
  },
}

config.font_size = 26.0

config.quick_select_patterns = {
  -- match things that look like sha1 hashes
  -- (this is actually one of the default patterns)
  '[0-9a-f]{3,40}/',
}

-- Needs nightly
-- config.quick_select_remove_styling = true

local function add_command_segment(label, c, t)
  local success, stdout, stderr = wezterm.run_child_process(c)

  if success and stdout ~= "" then
    table.insert(t, label .. " " .. stdout:gsub("%s+$", ""))
  end

  return t
end

local function segments_for_right_status(window)
  local segments = {
    window:active_workspace(),

  }

  segments = add_command_segment("k8s: ", { "kubectl", "config", "current-context" }, segments)
  segments = add_command_segment("🍌", { "/Users/michael/bin/kong-version" }, segments)

  return segments
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to, gradient_from = bg
  gradient_from = gradient_to:lighten(0.2)

  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

config.send_composed_key_when_left_alt_is_pressed = true

-- Finally, return the configuration to wezterm:
return config
