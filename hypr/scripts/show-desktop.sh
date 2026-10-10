#!/bin/bash
STATE_FILE="/tmp/hypr_show_desktop_state.json"

if [ -f "$STATE_FILE" ]; then
  # Restore: move each window back to where it came from
  jq -c '.[]' "$STATE_FILE" | while read -r entry; do
    addr=$(echo "$entry" | jq -r '.address')
    ws=$(echo "$entry" | jq -r '.workspace')
    hyprctl dispatch "hl.dsp.window.move({ workspace = '$ws', window = 'address:$addr', follow = false })"
  done
  rm "$STATE_FILE"
else
  # Hide: remember every window's current workspace, then park each in special:desktop
  hyprctl clients -j | jq '[.[] | select(.workspace.name | startswith("special:") | not) | {address: .address, workspace: .workspace.name}]' > "$STATE_FILE"
  jq -c '.[]' "$STATE_FILE" | while read -r entry; do
    addr=$(echo "$entry" | jq -r '.address')
    hyprctl dispatch "hl.dsp.window.move({ workspace = 'special:desktop', window = 'address:$addr', follow = false })"
  done
fi
