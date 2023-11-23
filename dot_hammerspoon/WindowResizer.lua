-- Split screen - X windows
local bind = {"cmd", "alt"}
function setWindowGrid(key, gridSettings)
  hs.hotkey.bind(bind, key, function()
    local win = hs.window.focusedWindow()
    hs.grid.set(win, gridSettings)
  end)
end

setWindowGrid("J", "0,0 3x2")
setWindowGrid("K", "3,0 3x2")
setWindowGrid("L", "6,0 2x2")
setWindowGrid("N", "0,0 4x2")
setWindowGrid("M", "4,0 4x2")
setWindowGrid(",", "2,0 4x2")
setWindowGrid(".", "0,0 8x2")