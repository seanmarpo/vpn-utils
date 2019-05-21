#!/bin/sh

echo "Stopping OpenVPN..."
sudo pkill -f "openvpn --config"

echo "[INFO] Removing network restrictions"
## Undo network restrictions and allow us to talk freely
sudo ufw --force reset 1>/dev/null
sudo ufw default deny incoming 1>/dev/null
sudo ufw default allow outgoing 1>/dev/null
sudo ufw --force enable 1>/dev/null

echo "[INFO] Checking network state..."
curl ipinfo.io


