//
// test_ser.ino
// Naookie Sato
//
// Created by Naookie Sato on 07/23/2019
// Copyright © 2018 Naookie Sato. All rights reserved.
//

#include <button.h>
#include <switch.h>
#include "serial_commands.h"

Switch switch1(&lock_session, &unlock_session, 7, INPUT);
Button button1(&minimize_all_windows, 8, LOW, INPUT_PULLUP);
Button button2(&activate_all_windows, 9, LOW, INPUT_PULLUP);

void setup() {
  Serial.begin(9600);
}

void loop() {
  button1.TriggerIfToggled();
  button2.TriggerIfToggled();
  switch1.TriggerIfToggled();
  delay(100);
}
