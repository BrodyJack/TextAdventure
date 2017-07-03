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

  Player(this.name, [this.gold = 10, this.health = 100, this.hunger = 0]) {
    this.inventory = new Inventory();
    this.skills = new Skills();
  }

  @override
  String toString() => "Player Name: $name\n";
}

class Inventory {
  List<Item> items; // 10 items max in inventory

  Inventory() {
    this.items = new List(10);
  }

  VerboseResult pickUpItem(Item item) {
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

class Item {
  int count;
  String name;
  String description;
  bool occupied;

  Item(this.name, this.description,
      {this.count = 0, this.occupied = false});

  bool operator ==(other) => other is Item && other.name == name;
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return "${name.padRight(35)}${count.toString().padRight(35)}"
        "${description.substring(0, min(11, description.length))}...";
  }
}

class Area {
  String name;
  String description;

  // The below fields will be set after creation
  String map;
  List<NPC> people;
  List<Item> items;
  Map<String, Area> exits;

  Area(this.name, this.description) {
    this.people = new List();
    this.items = new List();
    this.exits = new Map();
  }

  void toName() => stdout.writeln(name);
  void toDesc() => stdout.writeln(description);
  void toMap() => stdout.writeln(map);
}

class Skills {}

class NPC {}

class QuestLog {}

class Quest {}

class Equipment {}

class Weapon {} // ?? how to integrate this

class Armor {} // ?? how to integrate this

class GameStateManager {

  Player player;
  Map<String, Function> actions;
  List<String> words;

  GameStateManager(this.player) {
    this.actions =
    {"map": HandleMap, "inventory": HandleInventory, "quit": HandleQuit,
     "add": HandleTake, "pickup": HandleTake, "grab": HandleTake,
     "take": HandleTake, "where": HandleLocation, "travel": HandleMovement,
     "go": HandleMovement,};
  }


  void process(String input) {

    List<String> words_split = scrub(input);
    if (words_split.length == 0) {
      stdout.writeln("Could not recognize input.");
      return;
    }

    this.words = words_split;

    if (actions.containsKey(words[0])) {
      actions[words[0]]();
    } else {
      stdout.writeln("Could not recognize input.");
    }
  }

  void HandleInventory() {
    player.inventory.display();
  }

  void HandleMap() {
    player.currentLocation.toMap();
  }

  void HandleLocation() {
    player.currentLocation.toName();
    player.currentLocation.toDesc();
  }

  void HandleQuit() {
    stdout.write("Are you sure? (y/n): ");
    String input = stdin.readLineSync();
    if (input.toLowerCase().contains("y")) {
      stdout.writeln("Ending game!");
      exit(0);
    } else {
      stdout.writeln("Resuming...");
    }
  }

  void HandleMovement() {
    //TODO: Implement movement here
    // IDEA!!! Implement teleporting for easier traveling if you have the
    // resources
  }

  void HandleTake() {
    //TODO: Use below as reference. Decide how to do this.
    //InventoryItem toAdd = new InventoryItem(input.split("add ")[1], "Default"
    //    " Description");
    //VerboseResult result = player.inventory.pickUpItem(toAdd);
    //stdout.writeln(result.toString());
  }

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
