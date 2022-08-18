-- Wrap text
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
  -- Fetch URL from the system clipboard
  local linkUrl = hs.pasteboard.getContents()

  -- Copy the currently-selected text to use as the link text
	hs.eventtap.keyStroke({"cmd"}, "x")

  -- Allow some time for the command+c keystroke to fire asynchronously before
  -- we try to read from the clipboard
  hs.timer.doAfter(0.2, function()
    -- Construct the formatted output and paste it over top of the
    -- currently-selected text
    local linkText = hs.pasteboard.getContents()
    local content = '<a href="' .. linkUrl .. '">' .. linkText .. '</a>'
    hs.pasteboard.setContents(content)
    hs.eventtap.keyStroke({"cmd"}, "v")
    -- Allow some time for the command+v keystroke to fire asynchronously before
    -- we restore the original clipboard
    hs.timer.doAfter(0.2, function()
      hs.pasteboard.setContents(linkUrl)
    end)
  end)
end)