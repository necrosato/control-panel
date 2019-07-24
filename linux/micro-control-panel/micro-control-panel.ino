//
// test_ser.ino
// Naookie Sato
//
// Created by Naookie Sato on 07/23/2019
// Copyright © 2018 Naookie Sato. All rights reserved.
//

#include "include/button.h"

const int button1_pin = 8;

void setup() {
  Serial.begin(9600);
  pinMode(button1_pin, INPUT);
}

int button_state = LOW;

void new_fullscreen_terminal() {
  Serial.println("gnome-terminal --full-screen &");
}

Button button1(&new_fullscreen_terminal, button1_pin, HIGH);

void loop() {
  button1.TriggerIfToggled();
  delay(100);
}
