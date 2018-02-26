# Bootstrap
* __Use a sufficient power supply! Low power can cause system corruption!__
* `sudo apt update && sudo apt dist-upgrade -y`
 
## config

* `sudo raspi-config`
  * password
  * network, hostname
  * ssh
  * camera
  * extend file system
  * login options at boot
  * hdmi hotplug (boot/config.txt)
  * timezone
  
* [static ip](https://www.modmypi.com/blog/how-to-give-your-raspberry-pi-a-static-ip-address-update): edit `/etc/dhcpcd.conf`
  * Preferably IP reservation on router!
* [hostname](https://www.howtogeek.com/167195/how-to-change-your-raspberry-pi-or-other-linux-devices-hostname/): `/etc/hosts` and `/etc/hostname`

## packages
* must have
  
      sudo apt install mc apache2 lynx vlc libnss-winbind git build-essential
      
  for mail I used [mailsend](https://github.com/muquit/mailsend):
  
  IDK about the openssl libraries but install `libssl-dev` and/or `openssl-dev` also!
  
      git clone https://github.com/muquit/mailsend
      cd mailsend 
      ./configure --with-openssl=/usr
      make
      sudo make install
      cd

* optionals
  
      sudo apt install htop coreutils ntfs-3g

## Setup
* get the stuff

      git clone https://github.com/gaebor/guineacam

* apache
  * put the webpage under `/var/www/html/`
* mailsend uses a `mail.conf` file in the user's home which should contain 3 lines:
  * to
  * sender (gmail) username
  * sender password
* also configure your gmail to allow smtp: https://support.google.com/a/answer/6260879?hl=en
* put the `guineacam/guineacam.sh` script into `crontab -e` (crontab of `pi`, not for `root` !)
