//
// test_ser.ino
// Naookie Sato
//
// Created by Naookie Sato on 07/23/2019
// Copyright © 2018 Naookie Sato. All rights reserved.
//

#include "include/button.h"
#include "include/switch.h"
#include "serial_commands.h"

Button button1(&new_fullscreen_terminal, 8, HIGH);
Switch switch1(&lock_session, &unlock_session, 7);

void setup() {
  Serial.begin(9600);
}

void loop() {
  button1.TriggerIfToggled();
  switch1.TriggerIfToggled();
  delay(100);
}
