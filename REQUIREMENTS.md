# Device
raspberry pi 3 model b
## OS
Raspbian Jessie Lite
## Packages
* configure `iwconfig` to use static IP, unfortunately I get a DHCP also (?)
* `apache2` 
* `webiopi` unused at the moment
* `lynx` to find out your IP
* configure `mail` to send error reports
* enable camera via `raspi-config`
* `vlc` for streaming
* put `bash guineacam.sh` into `crontab` at `@reboot`
### Optional
* `libnss-winbind` to see other win shares: https://askubuntu.com/questions/507649/ubuntu-can-not-ping-host-name-but-can-ping-ip
