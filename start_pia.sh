#!/bin/sh

echo "[INFO] Checking for UFW..."
hash ufw 2>/dev/null || apt-get install ufw -y

echo "[INFO] Starting OpenVPN..."
cd ~/pia-vpn
## Pick an OVPN file at random
vpn=$(ls *.ovpn | shuf -n 1)
## Launch OpenVPN with that file as a daemon
openvpn --config $(pwd)/$vpn --daemon

echo "[INFO] Restricting network access to tun0"
## Only allow tun0 to talk to the world
ufw --force reset 1>/dev/null
ufw default deny incoming 1>/dev/null
ufw default deny outgoing 1>/dev/null
ufw allow out on tun0 from any to any 1>/dev/null
ufw --force enable 1>/dev/null

echo "[INFO] Checking network state..."
## Race condition where UFW finishes before OpenVPN finishes
## So, the obvious solution is a sleep delay
sleep 5
curl ipinfo.io
