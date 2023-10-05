-- Position windows for streaming
function setWindowPosition(key, w,h,x,y)
  hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, key, function()
    local win = hs.window.focusedWindow()
  
    local cursize = win:size()
    cursize.w = w
    cursize.h = h
    
    local f = win:frame()
    f.x = x
    f.y = y
  
    win:setFrame(f)
    win:setSize(cursize)
  end)
end
-- 1080p Right Browser (hide toolbar)
setWindowPosition("W", 1920, 1165, 2420, 0)

-- 1080p Left and Right
setWindowPosition("Q", 1920, 1165, 0, 285) -- Left
setWindowPosition("P", 1920, 1080, 2420, 285) -- Right
