#!/bin/bash
BAUD=9600
while getopts "hb:d:ml" opt; do
  case $opt in
    h )
      echo "Read and execute commands comming from a serial device."
      echo "-h : Display this help message."
      echo "-b : Baud rate, defaults to 9600."
      echo "-d : Serial device to read from, searches for serial device if not given."
      echo "-m : Monitor only, do not execute commands."
      echo "-l : Constantly look for a serial device. Helps if the device becomes disconnected."
      exit 0
      ;;
    b )
      BAUD=$OPTARG
      ;;
    d )
      SERIAL_DEVICE=$OPTARG
      ;;
    m )
      MONITOR="yes"
      ;;
    l )
      LIVE="true"
      ;;
  esac
done

kill_tail() {
  while [[ -e $1 ]]; do
    sleep 1
  done
  kill -9 $(ps -eo "pid,cmd" | grep "tail -f $1" | grep -v "grep" | awk '{print $1}')
}


while true; do
  if [[ "$LIVE" == "true" ]]; then
    SERIAL_DEVICE=$(find /dev/ -iname "ttyACM*")
  fi
  if [[ "$SERIAL_DEVICE" == "" ]]; then
    echo "No serial device found."
    sleep 1
    continue
  fi
  echo "Setting up serial terminal for device: $SERIAL_DEVICE"
  stty -F $SERIAL_DEVICE $BAUD -icanon min 0 -icrnl -ixon -opost -isig -iexten -echo -echoe -echok -echoctl -echoke
  echo "Baud rate set to $BAUD"

  echo "Reading from serial device: $SERIAL_DEVICE"
  kill_tail $SERIAL_DEVICE &
  while read -r line; do
    # Remove trailing whitespace
    line="$(echo -e "$line" | sed -e 's/[[:space:]]$//')"
    echo "$(TZ="America/Los_Angeles" date) - $line"
    if [[ "$MONITOR" == "" ]]; then
      $line > /tmp/serial_read.log 2>&1
    fi
  done < <(tail -f $SERIAL_DEVICE)
  wait -n 1
  echo "Connection terminated"
done
