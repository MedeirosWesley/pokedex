import 'package:flutter/cupertino.dart';
import 'package:pokedex/services/pokemon_service.dart';

import '../services/pokemonView_service.dart';
import '../states/pokemonView_state.dart';
import '../states/pokemon_state.dart';

class PokemonViewStore extends ValueNotifier<PokemonViewState> {
  final PokemonViewService service;
  PokemonViewStore(this.service) : super(InitialPokemonViewState());

  Future fetchPokemons(String id) async {
    value = LoadingPokemonViewState();
    try {
      final pokemon = await service.fetchPokemon(id: id);
      value = SuccessPokemonViewState(pokemon);
    } catch (e) {
      value = ErrorPokemonViewState(e.toString());
    }
  }
}
