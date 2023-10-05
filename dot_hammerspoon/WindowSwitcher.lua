function windowSwitch(binder)
  local windowId = 0;
  hs.hotkey.bind({"cmd", "alt", "ctrl", "shift" }, binder, function()
    windowId = hs.window.focusedWindow():id();
  end)
  
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, binder, function()
    hs.window.find(windowId):focus();
  end)
end

windowSwitch("y")
windowSwitch("u")
windowSwitch("i")
windowSwitch("h")
windowSwitch("j")
windowSwitch("k")