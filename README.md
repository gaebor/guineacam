# Bootstrap
## config

* `sudo -u pi passwd`
* `sudo raspi-config`
  * wifi
  * ssh
  * camera
  * extend file system
  * login options at boot
* `sudo apt update && sudo apt dist-upgrade -y`
* [static ip](https://www.modmypi.com/blog/how-to-give-your-raspberry-pi-a-static-ip-address-update): edit `/etc/dhcpcd.conf`
* set [hostname](https://www.howtogeek.com/167195/how-to-change-your-raspberry-pi-or-other-linux-devices-hostname/): `/etc/hosts` and `/etc/hostname`

## packages
* must have
  
      sudo apt install apache2 lynx vlc libnss-winbind mailutils
  
* optionals
  
      sudo apt install mc htop git build-essential coreutils

## Others
* apache
  * put the webpage under `/var/www/html/`
* configure mail
* put the `guineacam.sh` script into `crontab`
