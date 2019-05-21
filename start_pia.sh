#!/bin/sh

echo "[INFO] Checking for UFW..."
hash ufw 2>/dev/null || sudo apt install ufw -y

echo "[INFO] Starting OpenVPN..."
cd ~/pia-vpn
## Pick an OVPN file at random
vpn=$(ls *.ovpn | shuf -n 1)
## Launch OpenVPN with that file as a daemon
## Built-in sleep to ensure the openvpn connection establishes before performing network lockdown
sudo openvpn --config $(pwd)/$vpn --daemon
sleep 10

echo "[INFO] Restricting network access to tun0"
## Only allow tun0 to talk to the world
sudo ufw --force reset 1>/dev/null
sudo ufw default deny incoming 1>/dev/null
sudo ufw default deny outgoing 1>/dev/null
sudo ufw allow out on tun0 from any to any 1>/dev/null
sudo ufw --force enable 1>/dev/null

echo "[INFO] Checking network state..."
curl ipinfo.io
