# OpenVPN configuration for WSl2
Configuration files that expose WSL2 to LAN.

## Note: Please Use Test/Experimental Purpose Only
@yoshipon is not an expert on network security, and the scripts possibly include security holes.

Any [Issues](https://github.com/yoshipon/wsl-openvpn/issues) and [PRs](https://github.com/yoshipon/wsl-openvpn/pulls) to improve the security and usability are welcome  :)

## Quick Summary
The main idea is to connect WSL2 to LAN through the Windows host by using VPN bridging to the physical NIC.
This repository include
* `conf/server.ovpn`: a configuration file for an OpenVPN server on the Windows host
* `conf/client.conf`: a configuration file for an OpenVPN client on WSL2
* `conf/wsl.conf`: a configuration file for WSL to rename the hostname of WSL2
* `bin/start-services.sh`: a script file to start network services and obtain an IP address from a DHCP server

## Getting Started
### Configuration of Windows
1. [Install OpenVPN](https://openvpn.net/community-downloads-2/) on Windows host
2. Put `server.ovpn` on the configuration directory of OpenVPN (which may be found in your Start menu).
3. Make a directory `ca` on the configuration directory and generate the following key files:
   * `ca/ca.crt`, `ca/server.crt`, `ca/server.key`, `ca/dh2048.pem`, `client.crt`, `client.key`.
4. Open the `Network Connections` applet and make a bridge between your physical NIC (e.g., `Wi-Fi`) and `OpenVPN TAP-Windows6`.
### Configuration of WSl2
5. [Install OpenVPN](https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos) on your WSL2.
6. Rename `[win-hostname]` in `client.conf` to your Windows host name and move the file to `/etc/openvpn/`.
7. Make a directory `/etc/openvpn/ca` and copy `client.crt` and `client.key` into this directory.
8. Rename `[wsl-hostname]` in wsl.conf to change your WSL2 hostname from the Windows hostname and move this file to `/etc/`.
### Starting VPN
10. Start OpenVPN server on your Windows host.
9. Reboot your WSL2 by using `wsl.exe --shutdown`.
11. Start WSL2 and execute `start-services.sh`.
12. Now your WSL2 has a network adapter `tap0`, and any machines in LAN can access your WSL2 with `ssh [wsl-hostname].local`.

## Tips
* If the network speed gets extremely slow (e.g., 0.5Mbps), rebooting your machine sometimes resolves this problem.

## Known Issues/To Do
* Windows firewall configuration to accept only the access from WSL2
