import 'package:flutter/material.dart';

class ColorType {
  Color selectColor(String type) {
    switch (type.toLowerCase()) {
      case 'bug':
        return Colors.green;
      case 'dark':
        return Colors.black;
      case 'dragon':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'fairy':
        return Colors.purpleAccent;
      case 'fighting':
        return Colors.pink;
      case 'fire':
        return Colors.red;
      case 'flying':
        return Colors.blueAccent;
      case 'ghost':
        return Colors.indigo;
      case 'grass':
        return Colors.greenAccent;
      case 'ground':
        return Colors.orange;
      case 'ice':
        return Colors.cyan;
      case 'normal':
        return Colors.grey;
      case 'poison':
        return Colors.deepPurple;
      case 'psychic':
        return Colors.pinkAccent;
      case 'rock':
        return Colors.brown;
      case 'steel':
        return Colors.teal;
      case 'water':
        return Colors.lightBlue;
      default:
        return Colors.white;
    }
  }
}
