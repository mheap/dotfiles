
-- Prevent sleeping
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "I", function()
  hs.caffeinate.set("displayIdle", true, true)
  hs.caffeinate.set("systemIdle", true, true)
  hs.caffeinate.set("system", true, true)
  hs.alert.show("Preventing Sleep")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "O", function()
  hs.caffeinate.set("displayIdle", false, true)
  hs.caffeinate.set("systemIdle", false, true)
  hs.caffeinate.set("system", false, true)
  hs.alert.show("Allowing Sleep")
end)
