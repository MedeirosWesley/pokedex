import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokemonService {
  List<PokemonModel> pokemonList = [];

  Future<List<PokemonModel>> fetchPokemon() async {
    try {
      String url =
          'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
      final response = await Dio().get(url);
      final info = jsonDecode(response.data);
      final aux = info['pokemon'];
      for (var element in aux) {
        final map = {
          'id': element['id'].toString(),
          'name': element['name'],
          'types': element['type'],
          'abilities': {},
          'height': element['height'],
          'weight': element['weight'],
          'sprite':
              'https://cdn.traction.one/pokedex/pokemon/${element['id']}.png',
          'description': ''
        };
        pokemonList.add(PokemonModel.fromMap(map));
      }
    } catch (e) {
      print(e);
      Exception(e);
    }
    return pokemonList;
  }
}
