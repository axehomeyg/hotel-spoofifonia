#!/bin/bash
spoofer="./node_modules/.bin/spoof"

if [ ! -f $spoofer ] ; then
  echo "'spoof' not installed. Running npm install"
  npm install --save
fi

# APPLE TV MAC ID
if [ -f apple-tv-mac.txt ] ; then
  tvmac=`cat apple-tv-mac.txt`
  echo "Reading Apple TV Mac from ./apple-tv-mac.txt"
else
  echo Enter Apple TV MAC Address
  read tvmac
fi

# COMPUTER MAC ID and INTERFACE
interface=`$spoofer list --wifi | cut -d" " -f5`
computermac=`$spoofer list --wifi | cut -d" " -f9`

# BACKUP
echo $computermac > computermac.txt

# INFO 
echo "Apple TV Mac: $tvmac"
echo "Computer Wifi Interface: $interface"
echo "Computer Original Mac: $computermac"

# SPOOF!
echo "Spoofing Computer Mac ..."
sudo $spoofer set $tvmac $interface

# ACCEPT HOTEL TERMS
echo "Login to Hotel Wifi via your computer browser: Hit enter when complete to reset"
read loggedin

# RESET MAC
echo "Laptop Resetting"
sudo $spoofer reset wi-fi
