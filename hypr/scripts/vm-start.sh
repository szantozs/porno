#!/bin/bash
noctalia msg notification-show "WinApps" "Starting VM..."
podman-compose --file /home/zsombor/.config/winapps/compose.yaml up -d

for i in $(seq 1 60); do
  if nc -z 127.0.0.1 3389 2>/dev/null; then
    noctalia msg notification-show "WinApps" "VM is ready"
    exit 0
  fi
  sleep 5
done
noctalia msg notification-show "WinApps" "VM did not respond after 5 minutes"
