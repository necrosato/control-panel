//
// serial_commands.h
// Naookie Sato
//
// Created by Naookie Sato on 07/24/2019
// Copyright © 2018 Naookie Sato. All rights reserved.
//

#ifndef _HOME_NSATO_ARDUINO_SKETCHES_MICRO_CONTROL_PANEL_LINUX_MICRO_CONTROL_PANEL_INCLUDE_SERIAL_COMMANDS_H_
#define _HOME_NSATO_ARDUINO_SKETCHES_MICRO_CONTROL_PANEL_LINUX_MICRO_CONTROL_PANEL_INCLUDE_SERIAL_COMMANDS_H_

#include "Print.h"

void new_fullscreen_terminal() {
  Serial.println("gnome-terminal --full-screen");
}

void lock_session() {
  Serial.println("loginctl lock-session");
}

void unlock_session() {
  Serial.println("loginctl unlock-session");
}

#endif  // _HOME_NSATO_ARDUINO_SKETCHES_MICRO_CONTROL_PANEL_LINUX_MICRO_CONTROL_PANEL_INCLUDE_SERIAL_COMMANDS_H_
