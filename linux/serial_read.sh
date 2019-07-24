#!/bin/bash


SERIAL_DEVICE=$(find /dev/ -iname "TTYACM*")
echo "Reading from serial device: $SERIAL_DEVICE"

while read -r line; do
  # Remove trailing whitespace
  line="$(echo -e "$line" | sed -e 's/[[:space:]]$//')"
  echo "$line"
  $line
done < <(tail -f $SERIAL_DEVICE)
