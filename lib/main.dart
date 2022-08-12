import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokemon_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(useMaterial3: true),
      home: PokemonPage(color: Colors.black, pokemonId: "1"),
    );
  }
}
