require('Orbstack')
require('Sleep')
require('WindowSwitcher')
require('Layouts') -- Predefined layouts
require('WindowResizer') -- Move the active window
require('WindowPositioner') -- Original for streaming
require('WrapLink')

hs.window.animationDuration = 0.00

function printTable(result)
  for i,v in ipairs(result) do print(i,v) end
end

-- Reload Config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

hs.alert.show("Config loaded")

-- Testing
hyper = {'cmd', 'alt', 'ctrl', 'shift'}

appMaps = {
  a = 'Arc',
  v = 'Visual Studio Code - Insiders',
  s = 'Slack',
  f = 'Sunsama',
  d = 'iTerm',
  b = 'Bear',
  z = 'Spotify',
  t = 'Todoist',
  x = 'Fantastical'
}

for appKey, appName in pairs(appMaps) do
  hs.hotkey.bind(hyper, appKey, function()
    hs.application.launchOrFocus(appName)
  end)
end

-- Grid
hs.grid.setMargins(hs.geometry.size(0,0))
hs.grid.setGrid('8x2')

hs.hotkey.bind(hyper,'g',function()
  hs.grid.show()
end)
