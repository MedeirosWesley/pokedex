import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemonView_model.dart';
import 'package:translator/translator.dart';

class PokemonViewService {
  Future<PokemonViewModel> fetchPokemon({required String id}) async {
    try {
      String url = 'https://pokeapi.glitch.me/v1/pokemon/$id';
      final response = await Dio().get(url);
      final info = response.data[0];
      var description;
      await GoogleTranslator()
          .translate(info['description'], from: 'en', to: 'pt')
          .then((value) => description = value.text);
      final map = {
        'id': info['number'],
        'name': info['name'],
        'types': info['types'],
        'abilities': info['abilities'],
        'height':
            '${(double.parse(info['height'].replaceAll('\"', '').replaceAll('\'', '.')) * 0.3048).toStringAsFixed(2).replaceAll('.', ',')} M',
        'weight':
            '${(double.parse(info['weight'].replaceAll(' lbs.', '')) * 0.453592).toStringAsFixed(2).replaceAll('.', ',')} KG',
        'sprite': info['sprite'],
        'description': description,
      };
      return PokemonViewModel.fromMap(map);
    } catch (e) {
      throw Exception();
    }
  }
}
