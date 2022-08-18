function windowSwitch(binder)
  local windowId = 0;
  hs.hotkey.bind({"cmd", "alt", "ctrl" }, binder, function()
    windowId = hs.window.focusedWindow():id();
  end)
  
  hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, binder, function()
    hs.window.find(windowId):focus();
  end)
end

windowSwitch("2")
windowSwitch("3")
windowSwitch("4")