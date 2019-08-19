#!/bin/bash
# This is a script that I created to simplify my RaspberryPi's HDMI Power Cron Jobs a bit.
# When the argument 'off' is given, it simply tells dpms to forcibly turn off... which only blanks the screen
# It then tells tvservice to turn off HDMI... which then drops the connection to HDMI Display completely... typically making it enter standby.
# When the argument 'on' is given, it tells tvservice to turn on HDMI using the preferred settings, it then tells dpms to forcibly unblank... 
# I have that sleep for 5s there as there is a bug where when tvservice starts up... dpms is blanking the screen still until HDMI fully comes up,
# even if the dpms force off was never sent.
# github.com/yuniq_neko
case $1 in
on)
  /opt/vc/bin/tvservice -p
  sleep 5
  DISPLAY=:0 xset dpms force on
  echo "HDMI Powered On"
  exit 0
;;
off)
  DISPLAY=:0 xset dpms force off
  /opt/vc/bin/tvservice -o
  echo "HDMI Powered Off"
  exit 0
;;
*)
  echo "Sorry, please use the arguments 'on' or 'off'"
  exit 1
;;
esac
