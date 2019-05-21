#!/bin/bash

echo "[INFO] Installing openvpn & ufw..."
sudo apt update && sudo apt install openvpn ufw -y

echo "[INFO] Creating VPN file structure..."
rm -rf ~/pia-vpn 2> /dev/null
mkdir -p ~/pia-vpn
cd ~/pia-vpn

echo "[INFO] Downloading PIA OpenVPN files..."
wget -q --show-progress https://www.privateinternetaccess.com/openvpn/openvpn.zip
unzip -q openvpn.zip
rm openvpn.zip

echo "[INFO] Cleaning up PIA VPN files..."
## List all ovpn files, inverse grep for anything NOT in the US
## and then remove those files
## aka: Keep only US-based servers (for speed)
ls *.ovpn | grep -v "US" | xargs -d '\n' rm
## Remove spaces in VPN file names
for f in *\ *; do mv "$f" "${f// /_}"; done
## Add in pre-configured auth to all OVPN files
sed -i '/auth-user-pass/c\auth-user-pass pia.conf' *.ovpn

echo "[INFO] Creating PIA creds file"
echo "PIA Username:"
read user
echo "PIA Password:"
read -s password
echo "$user" > pia.conf
echo "$password" >> pia.conf

# It just feels better to restrict permissions on this.
# Does not add a whole lot though.
chmod 600 ~/pia-vpn/pia.conf

echo "[SUCCESS] PIA configured"



