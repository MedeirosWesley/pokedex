import 'package:flutter/cupertino.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/services/pokemon_service.dart';

import '../states/pokemon_state.dart';

class PokemonStore extends ValueNotifier<PokemonState> {
  final PokemonService service;
  PokemonStore(this.service) : super(InitialPokemonState());

  Future fetchPokemons() async {
    value = LoadingPokemonState();
    try {
      final pokemons = await service.fetchPokemon();
      value = SuccessPokemonState(pokemons);
    } catch (e) {
      value = ErrorPokemonState(e.toString());
    }
  }
}
