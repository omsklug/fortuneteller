#!/bin/bash
# Description: This is small fortuneteller script using USB as activation trigger.
# Author: Copyright (C) 2015 Al Tarakanoff al.tarakanoff@gmail.com
# License: 
# This program is free software: you can redistribute it and/or modify it under the terms of 
# the GNU General Public License as published by the Free Software Foundation, either version 3 
# of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. 
# If not, see http://www.gnu.org/licenses/.
# Comments:
# You have to install FOSS three programs: fortune, pinpoint, avconv
# sudo apt-get install fortunes pinpoint libav-tools
# And also you have to add udev script 90-usb-fortunes.rules to /etc/udev/rules.d:
# ACTION=="add", DEVPATH=="/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2" RUN+="/bin/bash /home/omsklug/scripts/fortuneteller.sh"
# ACTION=="remove", DEVPATH=="/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2" RUN+="/usr/bin/pkill '^pinpoint*'"
# ...where DEVPATH is your favorite USB port for connection
export DISPLAY=":0"
export LANG=ru_RU.UTF-8
#Active user with X-display access to show fortunes
USER=omslug
DATADIR=/home/$USER/scripts/fortunetellerdata/
DATE=$(/bin/date +%Y%m%d%H%M%S)
FORTUNE=$(/usr/games/fortune)
STYLE="-- [black] [font='Droid Sans' 100px] [duration=10] [transition=spin-text]"
cd $DATADIR
/usr/bin/sudo -u $USER /usr/bin/avconv -f video4linux2 -s 1280x800 -i /dev/video0 -vframes 60 -r 30 $DATE.mkv &
/usr/bin/sudo -u $USER /bin/echo $STYLE > $DATE.pin
/usr/bin/sudo -u $USER /bin/echo -e $FORTUNE | fold -s -w 40 >> $DATE.pin
/bin/chown $USER:$USER $DATE.pin
/usr/bin/sudo -u $USER /usr/bin/pinpoint -f $DATE.pin &
exit 0
