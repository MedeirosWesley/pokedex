import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokemonService {
  List<PokemonModel> pokemonList = [];

  Future<List<PokemonModel>> fetchPokemon() async {
    try {
      for (int i = 1; i <= 20; i++) {
        String url = 'https://pokeapi.glitch.me/v1/pokemon/$i';
        final response = await Dio().get(url);
        final list = response.data as List;
        final info = list[0];
        final map = {
          'id': info['number'],
          'name': info['name'],
          'types': info['types'],
          'abilities': info['abilities'],
          'height': info['height'],
          'weight': info['weight'],
          'sprite': info['sprite'],
          'description': info['description']
        };
        print(map['id']);
        pokemonList.add(PokemonModel.fromMap(map));
      }
    } catch (e) {
      print(e);
    }
    return pokemonList;
  }
}
