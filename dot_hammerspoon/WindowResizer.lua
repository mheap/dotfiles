
-- Split screen - X windows
function setPercentScreen(bind, portion, key, index)
  hs.hotkey.bind(bind, key, function()
    local win = hs.window.focusedWindow()

    local section_width = (5120/portion) -- 5120 is the screen width
  
    local cursize = win:size()
    cursize.w = section_width
    cursize.h = 1440
    
    local f = win:frame()
    f.x = index * section_width
    f.y = 0
  
    win:setFrame(f)
    win:setSize(cursize)
  end)
end

function setQuarterScreen(key, index)
  setPercentScreen({"cmd", "alt", "ctrl"}, 4, key, index)
end

function setThirdScreen(key, index)
  setPercentScreen({"cmd", "alt"}, 3, key, index)
end

setQuarterScreen("Y", 0)
setQuarterScreen("U", 1)
setQuarterScreen("I", 2)
setQuarterScreen("O", 3)

setThirdScreen("Y", 0)
setThirdScreen("U", 1)
setThirdScreen("I", 2)
