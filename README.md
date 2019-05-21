# VPN-Utils
My (slightly sane) way to manage PIA VPN on my VMs. Sometimes you just don't want your ISP to know what you're doing. This will download the OVPN files from PIA, only keep the US servers, and configure UFW to only allow outbound connections over the VPN when running. In theory, this should ensure you do not leak your actual IP Address inadvertently.

## Usage
### Setup on a new VM
`/configure_pia.sh`
* You will be prompted for your PIA credentials so that life is less painful later.

### Starting PIA VPN Connection
`./start_pia.sh`
* Add this to your `~/.bashrc` if you so desire
* ufw is invoked and will only allow connections outbound via the `tun0` interface created by OpenVPN (in case you suddently lose access to your local network, this is why)

### Stopping PIA VPN Connection
`./stop_pia.sh`
* Add this to your `~/.bashrc` if you so desire
* ufw restrictions are removed when this is run

## Caveats
Your PIA credentials are saved in plaintext to disk at: `~/pia-vpn/pia.conf`. This is not ideal. I recognize this. I use these on VMs, so my risk is a lot less considering the host OS has all the other security features I deem necessary enabled. Obviously, consider your own risk tolerance if you so decide to use this.
