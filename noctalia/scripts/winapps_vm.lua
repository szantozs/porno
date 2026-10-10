local initialized = false

function update()
  if not initialized then
    barWidget.setUpdateInterval(5000) -- check every 5 seconds, not the 250ms default
    initialized = true
  end

  local exitCode, stdout = noctalia.runSync("podman inspect -f '{{.State.Running}}' winapps 2>/dev/null")

  if exitCode == 0 and stdout:match("true") then
    barWidget.setGlyph("player-play")
    barWidget.setText("VM Up")
    barWidget.setGlyphColor("primary")
  else
    barWidget.setGlyph("player-stop")
    barWidget.setText("VM Down")
    barWidget.setGlyphColor("on_surface_variant")
  end
end

function onClick()
  noctalia.runAsync(os.getenv("HOME") .. "/.config/hypr/scripts/vm-start.sh")
end

function onRightClick()
  noctalia.runAsync(os.getenv("HOME") .. "/.config/hypr/scripts/vm-stop.sh")
end
