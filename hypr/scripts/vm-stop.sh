#!/bin/bash
noctalia msg notification-show "WinApps" "Shutting down VM..."
podman-compose --file /home/zsombor/.config/winapps/compose.yaml down
noctalia msg notification-show "WinApps" "VM shut down"
