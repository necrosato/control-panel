#!/bin/bash

SERIAL_DEVICE=$(find /dev/ -iname "ttyACM*")
BAUD=9600
while getopts "hb:d:" opt; do
  case $opt in
    h )
      echo "Read and execute commands comming from a serial device."
      echo "-h : Display this help message."
      echo "-b : Baud rate, defaults to 9600."
      echo "-d : Serial device to read from, searches for serial device if not given."
      exit 0
      ;;
    b )
      BAUD=$OPTARG
      ;;
    d )
      SERIAL_DEVICE=$OPTARG
      ;;
  esac
done

echo "Baud rate set to $BAUD"

if [[ "$SERIAL_DEVICE" == "" ]]; then
  echo "No serial device found."
  exit 1
fi

echo "Setting up serial terminal for device: $SERIAL_DEVICE"
stty -F $SERIAL_DEVICE $BAUD -icanon min 0 -icrnl -ixon -opost -isig -iexten -echo -echoe -echok -echoctl -echoke

echo "Reading from serial device: $SERIAL_DEVICE"
while read -r line; do
  # Remove trailing whitespace
  line="$(echo -e "$line" | sed -e 's/[[:space:]]$//')"
  echo "$(TZ="America/Los_Angeles" date) - $line"
  $line
done < <(tail -f $SERIAL_DEVICE)
