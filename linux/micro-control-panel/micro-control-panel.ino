//
// test_ser.ino
// Naookie Sato
//
// Created by Naookie Sato on 07/23/2019
// Copyright © 2018 Naookie Sato. All rights reserved.
//

const int button1_pin = 8;

void setup() {
  Serial.begin(9600);
  pinMode(button1_pin, INPUT);
}

int button_state = LOW;

void new_fullscreen_terminal() {
  Serial.println("gnome-terminal --full-screen &");
}

void loop() {
  int button_state_tmp = digitalRead(button1_pin);
  if (button_state != button_state_tmp) {
    button_state = button_state_tmp;
    if (button_state == HIGH) {
      new_fullscreen_terminal();
    }
  }
  delay(100);
}
