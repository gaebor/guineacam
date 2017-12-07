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

## packages
* must have
  
      sudo apt install apache2 lynx vlc libnss-winbind
  
* optionals
  
      sudo apt install mc htop git build-essential coreutils
