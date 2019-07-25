#!/bin/bash


SERIAL_DEVICE=$(find /dev/ -iname "ttyACM*")
BAUD=9600

if [[ "$SERIAL_DEVICE" == "" ]]; then
  echo "No serial device found."
  exit 1
fi

stty -F $SERIAL_DEVICE $BAUD -icanon min 0

echo "Reading from serial device: $SERIAL_DEVICE"

while read -r line; do
  # Remove trailing whitespace
  line="$(echo -e "$line" | sed -e 's/[[:space:]]$//')"
  echo "$(TZ="America/Los_Angeles" date) - $line"
  $line
done < <(tail -f $SERIAL_DEVICE)
