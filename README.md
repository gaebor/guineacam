# Bootstrap
## config

* `sudo raspi-config`
  * password
  * wifi
  * ssh
  * camera
  * extend file system
  * login options at boot
  * hdmi hotplug (boot/config.txt)
  * timezone
  
* `sudo apt update && sudo apt dist-upgrade -y`
  * Don't do this over ssh, IDK why, but it breaks. Connect a monitor & keyboard!
* [static ip](https://www.modmypi.com/blog/how-to-give-your-raspberry-pi-a-static-ip-address-update): edit `/etc/dhcpcd.conf`
  * Preferably IP reservation on router!
* set [hostname](https://www.howtogeek.com/167195/how-to-change-your-raspberry-pi-or-other-linux-devices-hostname/): `/etc/hosts` and `/etc/hostname`

## packages
* must have
  
      sudo apt install apache2 lynx vlc libnss-winbind git build-essential
      
  for mail I used [mailsend](https://github.com/muquit/mailsend):
  
      sudo apt-get install openssl openssl-dev
      git clone https://github.com/muquit/mailsend
      cd mailsend 
      ./configure --with-openssl=/usr
      make
      sudo make install
      cd

* optionals
  
      sudo apt install mc htop coreutils ntfs-3g

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
* put the `guineacam/guineacam.sh` script into `crontab -e`
