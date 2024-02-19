cp BIN/* /usr/local/bin

chmod +x /usr/local/bin/wifi
chmod +x /usr/local/bin/modem
chmod +x /usr/local/bin/color

apt install network-manager

/sbin/usermod -aG audio,video,sudo $(id -un 1000)

reboot
