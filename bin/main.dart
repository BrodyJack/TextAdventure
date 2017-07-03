// Copyright (c) 2017, brodyjohnstone. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:TextGame/TextGame.dart';
import 'package:TextGame/Utilities.dart';
import 'dart:io';

Player player = null;
GameStateManager gsm = null;

main() {
  player = new Player(intro());
  player.currentLocation = setupAreas();
  gsm = new GameStateManager(player);
  // additional setup

  while (true) {
    stdout.write("> ");
    String input = stdin.readLineSync();
    gsm.process(input);
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
  VerboseResult result = player.inventory.pickUpItem(new Item(
      "Dragon Chainbody", "Runescape Boyz"));
  printlnWithDelay(result);
  player.inventory.display();

  for (int i = 1; i < player.inventory.items.length + 1; i++) {
    var result = player.inventory.pickUpItem(new Item(
        i.toString(), "Test"));
    printlnWithDelay(result);
    player.inventory.display();
    sleep(new Duration(milliseconds: 500));
  }
}

Area setupAreas() {
  Area lumbridge = new Area("Lumbridge", "Lumbridge is the beginner "
      "area of the game.");
  lumbridge.map = r"""
                                               //////
                    Lumbridge                ///////
                                          /////////
                                         /////////xxx
             XXXXXXX                    /////////xxxx
     XXXXXXXXXXXXXXX                   /////////xxxxx
  XXXXXXXXXXXXXXXXXX                 //////////xxxxxx
  XXXXXXXXXXXXXXXXXX                 /////////xxxxxxx
 XXXXXXXXXXXXXXXXXXXX+-------------------------->xxxx      x
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxxx
XXXXXXX+----+XXXXXXXX<--------------------------+xxx
XXXXXXX|----|XXXXXX               /////////xxxxxxx x
 XXXXXX|----|XXXXXXXXX           /////////xxxxxxxxxx
 XXXXXX|----|XXXXXXXXXXX        /////////xxxxxxxxx x
  XXXXX+----+XXXXX+--+XXX     //////////xxxxxxxxxx x
    XXXXXXXXXXXXXX|--|XXXXX  ////////// xxxxxx xx
         XXXXXXXXX|--|XXXXXX////////// xxxxxxxxxx
         XXXXXXXXX+--+XXXXX /////////  xxxxxxxxx
              XXXXXXXXXXXX /////////   xxxxxxxxxx
                XXXXXXXXXX//////////      xxxxxxx
                     XXX  /////////        xxxxxx
                            //////
                             / //
  """;
  lumbridge.items = [new Item("Iron Bar", "It's a bar of iron."),
    new Item("Bronze Bar", "It's a bar of bronze."),
    new Item("Steel Pickaxe", "This can be used to mine."
  )];

  lumbridge.exits["north"] = new Area("Draynor", "A fishing and woodcutting"
      " village north of Lumbridge.");
  lumbridge.exits["east"] = new Area("Al Kharid", "A desert landscape home"
      " to Glienor's most ruthless Duel Arena.");
  lumbridge.exits["south"] = new Area("Lumbridge Swamp", "A swampy area.");

  return lumbridge;
}
