# fortuneteller
This is small fortuneteller script using USB as activation trigger
You have to install FOSS three programs: fortune, pinpoint, avconv
sudo apt-get install fortunes pinpoint libav-tools
And also you have to add udev script 90-usb-fortuneteller.rules to /etc/udev/rules.d:
ACTION=="add", DEVPATH=="/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2" RUN+="/bin/bash /home/omsklug/scripts/fortuneteller.sh"
ACTION=="remove", DEVPATH=="/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2" RUN+="/usr/bin/pkill '^pinpoint*'"
...where DEVPATH is your favorite USB port for connection
