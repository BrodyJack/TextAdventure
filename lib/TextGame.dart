// Copyright (c) 2017, brodyjohnstone. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "dart:math";
import "package:TextGame/Utilities.dart";
import "dart:io";

class Player {
  Inventory inventory;
  Skills skills;
  String name;
  int health; // 0 dead, 100 full health
  int gold; // 0 is the base, no cap
  int hunger; // 0 not hungry, 100 very hungry
  Area currentLocation;
  QuestLog questlog;
  Equipment equipped;

  Player(this.name, [this.gold = 0, this.health = 100, this.hunger = 0]) {
    this.inventory = new Inventory();
    this.skills = new Skills();
  }

  @override
  String toString() => "Player Name: $name\n";
}

class Inventory {
  List<InventoryItem> items; // 10 items max in inventory

  Inventory() {
    this.items = new List(10);
  }

  VerboseResult pickUpItem(InventoryItem item) {
    int location = items.indexOf(item);
    if (location != -1) {
      items[location].count++;
      return new VerboseResult(true, "You picked up another ${item.name}.");
    } else {
      location = items.indexOf(null);
      if (location != -1) {
        items[location] = item;
        items[location].count++;
        return new VerboseResult(true, "You picked up a"
            " ${item.name}!");
      } else {
        return new VerboseResult(false, "Your inventory is full."
            " Did not pick item up.");
      }
    }
  }

  VerboseResult dropItem(String name, int count) {
    // Create a dummy InventoryItem for comparisons
    InventoryItem temp = new InventoryItem(name, "");
    int location = items.indexOf(temp);
    if (location != -1) {
      // we do have an item!
      if (items[location].count - count <= 0) {
        // consider adding a confirmation check
        items[location] = null;
        return new VerboseResult(true, "Dropped all $name(s).");
      } else {
        items[location].count -= count;
        return new VerboseResult(true, "Dropped $count $name(s). You"
            " have ${items[location].count} remaining.");
      }
    } else {
      return new VerboseResult(false, "You do not have any of that item.");
    }
  }

  void display() {
    print(this.toString());
  }

  @override
  String toString() {
    String display = "${"Item Name".padRight(35)}${"Amount".padRight(35)}"
        "Description\n";
    display += "${"---------".padRight(35)}${"------".padRight(35)}"
        "-----------\n";

    bool allNull = true;

    for (int i = 0; i < items.length; i++) {
      if (items[i] == null) {
        continue;
      } else {
        allNull = false;
        display += items[i].toString() + "\n";
      }
    }

    return allNull
        ? "Your inventory is empty!"
        : display;
  }
}

class InventoryItem {
  int count;
  String name;
  String description;
  bool occupied;

  InventoryItem(this.name, this.description,
      {this.count = 0, this.occupied = false});

  bool operator ==(other) => other is InventoryItem && other.name == name;
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return "${name.padRight(35)}${count.toString().padRight(35)}"
        "${description.substring(0, min(11, description.length))}...";
  }
}

class Skills {}

class Area {}

class QuestLog {}

class Quest {}

class Equipment {}

class Weapon {} // ?? how to integrate this

class Armor {} // ?? how to integrate this

class GameStateManager {
  void process(String input, Player player) {
    if (input.toLowerCase().contains("show i")) {
      player.inventory.display();
    } else if (input.toLowerCase().contains("show m")) {
      stdout.writeln(map);
    } else if (input.toLowerCase().contains("quit")) {
      stdout.write("Are you sure? (y/n): ");
      String input = stdin.readLineSync();
      if (input.toLowerCase().contains("y")) {
        stdout.writeln("Ending game!");
        exit(0);
      } else {
        stdout.writeln("Resuming...");
      }
    } else if (input.toLowerCase().contains("add")) {
      InventoryItem toAdd = new InventoryItem(input.split("add ")[1], "Default"
          " Description");
      VerboseResult result = player.inventory.pickUpItem(toAdd);
      stdout.writeln(result.toString());
    } else {
      stdout.writeln("Could not recognize input.");
    }
  }

  String map = r"""
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

} // ?? details

//class NumericalResult {
//  bool success;
//  int num;
//
//  NumericalResult(this.success, this.num);
//}

int calculate() {
  return 6 * 7;
}
