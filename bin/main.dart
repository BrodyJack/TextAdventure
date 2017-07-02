// Copyright (c) 2017, brodyjohnstone. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:TextGame/TextGame.dart';
import 'package:TextGame/Utilities.dart';
import 'dart:io';

main() {
  Player player = new Player(intro());
  GameStateManager gsm = new GameStateManager();
  // additional setup

  while (true) {
    stdout.write("> ");
    String input = stdin.readLineSync();
    gsm.process(input, player);
  }
}

String intro() {
  printlnWithDelay("------------Welcome to Bjordson's Trial------------");
  printWithDelay(".");
  printWithDelay(".");
  printWithDelay(".");
  printWithDelay(".\r");
  printWithDelay(".");
  printWithDelay(".");
  printlnWithDelay(".\r");
  ///--------------------------------

  stdout.write("What is your name?: ");
  String name = stdin.readLineSync();
  printWithDelay(".");
  printWithDelay(".");
  printlnWithDelay(".");
  printlnWithDelay("So, you are ${name}. Welcome.\n");
  return name;
}

void testingInventory(Player player) {
  print(player);
  player.inventory.display();
  VerboseResult result = player.inventory.pickUpItem(new InventoryItem(
      "Dragon Chainbody", "Runescape Boyz"));
  printlnWithDelay(result);
  player.inventory.display();

  for (int i = 1; i < player.inventory.items.length + 1; i++) {
    var result = player.inventory.pickUpItem(new InventoryItem(
        i.toString(), "Test"));
    printlnWithDelay(result);
    player.inventory.display();
    sleep(new Duration(milliseconds: 500));
  }
}
