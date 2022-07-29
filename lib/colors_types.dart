import 'package:flutter/material.dart';

class ColorType {
  Color selectColor(String type) {
    switch (type.toLowerCase()) {
      case 'bug':
        return Colors.green.withOpacity(.5);
        ;
      case 'dark':
        return Colors.black.withOpacity(.5);
        ;
      case 'dragon':
        return Colors.blue.withOpacity(.2);
      case 'eletric':
        return Colors.yellow.withOpacity(.2);
        ;
      case 'fairy':
        return Colors.purpleAccent.withOpacity(.2);
      case 'fighting':
        return Colors.pink.withOpacity(.2);
      case 'fire':
        return Colors.red.withOpacity(.2);
      case 'flying':
        return Colors.blueAccent.withOpacity(.2);
      case 'gost':
        return Colors.indigo.withOpacity(.2);
      case 'grass':
        return Colors.greenAccent.withOpacity(.2);
      case 'ground':
        return Colors.orange.withOpacity(.2);
      case 'ice':
        return Colors.cyan.withOpacity(.2);
      case 'normal':
        return Colors.grey.withOpacity(.2);
      case 'poison':
        return Colors.deepPurple.withOpacity(.2);
      case 'psychic':
        return Colors.pinkAccent.withOpacity(.2);
      case 'rock':
        return Colors.brown.withOpacity(.2);
      case 'steel':
        return Colors.teal.withOpacity(.2);
      case 'water':
        return Colors.lightBlue.withOpacity(.2);
      default:
        return Colors.white;
    }
  }
}
