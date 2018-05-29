#!/bin/sh

echo "Stopping OpenVPN..."
pkill -f "openvpn --config"

echo "[INFO] Removing network restrictions"
## Undo network restrictions and allow us to talk freely
ufw --force reset 1>/dev/null
ufw default deny incoming 1>/dev/null
ufw default allow outgoing 1>/dev/null
ufw --force enable 1>/dev/null

echo "[INFO] Checking network state..."
curl ipinfo.io


