require('Orbstack')
require('Sleep')
require('WindowSwitcher')
require('WindowResizer') -- New for day to day
require('WindowPositioner') -- Original for streaming
require('WrapLink')

-- Reload Config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

hs.alert.show("Config loaded")
