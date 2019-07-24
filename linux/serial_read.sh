#!/bin/bash


SERIAL_DEVICE=$(find /dev/ -iname "TTYACM*")
echo "Reading from serial device: $SERIAL_DEVICE"

while read -r line; do
  $line
done < <(tail -f $SERIAL_DEVICE)
