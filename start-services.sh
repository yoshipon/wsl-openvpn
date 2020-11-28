#! /bin/bash

sudo service dbus start
sudo service openvpn start
sleep 5
sudo dhclient tap0
sudo service ssh start
sudo service avahi-daemon start
