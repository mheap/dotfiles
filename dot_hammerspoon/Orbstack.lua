hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "R", function()
  hs.execute("/Users/michael/bin/orb delete k8s -f && /Users/michael/bin/orb start k8s")
  hs.alert.show("Kubernetes Cluster Reset")
end)