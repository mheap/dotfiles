
-- Split screen - X windows
function setPercentScreen(bind, portion, key, index, altScreen)
  hs.hotkey.bind(bind, key, function()
    local win = hs.window.focusedWindow()

    local section_width = (5120/portion) -- 5120 is the screen width
    local xmod = 0;
    if altScreen then
      section_width = (3440/portion) -- 3440 is the screen width for the alt screen
      xmod = -3440
    end
  
    local cursize = win:size()
    cursize.w = section_width
    cursize.h = 1440
    
    local f = win:frame()
    f.x = (index * section_width)+xmod
    f.y = 0
  

    win:setFrame(f)
    win:setSize(cursize)
  end)
end

function setQuarterScreen(key, index)
  setPercentScreen({"cmd", "alt"}, 4, key, index)
end

function setThirdScreen(key, index)
  setPercentScreen({"cmd", "alt"}, 3, key, index)
end

function setHalfScreen(key, index)
  setPercentScreen({"cmd", "alt"}, 2, key, index)
end

setQuarterScreen("Y", 0)
setQuarterScreen("U", 1)
setQuarterScreen("I", 2)
setQuarterScreen("O", 3)

setThirdScreen("H", 0)
setThirdScreen("J", 1)
setThirdScreen("K", 2)

setHalfScreen("N", 0)
setHalfScreen("M", 1)

setPercentScreen({"cmd", "alt"}, 1, ".", 0)

-- Unusual sizing
setPercentScreen({"cmd", "alt", "ctrl"}, 6, "J", 3)
setPercentScreen({"cmd", "alt", "ctrl"}, 6, "K", 4)
setPercentScreen({"cmd", "alt", "ctrl"}, 6, "L", 5)

setPercentScreen({"cmd", "alt", "ctrl"}, 8, "N", 4)
setPercentScreen({"cmd", "alt", "ctrl"}, 8, "M", 5)
setPercentScreen({"cmd", "alt", "ctrl"}, 8, ",", 6)
setPercentScreen({"cmd", "alt", "ctrl"}, 8, ".", 7)

setPercentScreen({"cmd", "alt", "shift"}, 1, ".", 0, true)
setPercentScreen({"cmd", "alt", "shift"}, 2, "N", 0, true)
setPercentScreen({"cmd", "alt", "shift"}, 2, "M", 1, true)