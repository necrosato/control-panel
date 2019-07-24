//
// button.cpp
// Naookie Sato
//
// Created by Naookie Sato on 07/24/2019
// Copyright © 2018 Naookie Sato. All rights reserved.
//

#include <Arduino.h>
#include "../include/button.h"

Button::Button(void (*action)(), int pin, int trigger_state) :
    action_(action), pin_(pin), trigger_state_(trigger_state), button_state_(!trigger_state) {
  pinMode(pin, INPUT);
}

bool Button::TriggerIfToggled() {
  if (IsToggled() && button_state_ == trigger_state_) {
    action_();
    return true;
  }
  return false;
}

int Button::PinState() {
  return digitalRead(pin_);
}

bool Button::IsToggled() {
  int state_tmp = PinState();
  if (button_state_ != state_tmp) {
    button_state_ = state_tmp;
    return true;
  }
  return false;
}
