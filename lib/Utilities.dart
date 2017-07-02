// Copyright (c) 2017, brodyjohnstone. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "dart:io";

void printWithDelay([Object object = "", int delay = 500]) {
  stdout.write(object);
  sleep(new Duration(milliseconds: delay));
}

void printlnWithDelay([Object object = "", int delay = 500]) {
  stdout.writeln(object);
  sleep(new Duration(milliseconds: delay));
}

String strike(String s) {
  String new_string = '';
  for (int i = 0; i < s.length; i++) {
    new_string = new_string + s[i] + "\u0336";
  }
  return new_string;
}

class VerboseResult {
  bool success;
  String error;

  VerboseResult(this.success, this.error);

  @override
  String toString() {
    return error;
  }
}