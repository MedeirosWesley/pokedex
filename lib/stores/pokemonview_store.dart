import 'package:flutter/cupertino.dart';
import '../services/pokemon_view_service.dart';
import '../states/pokemon_view_state.dart';

class PokemonViewStore extends ValueNotifier<PokemonViewState> {
  final PokemonViewService service;
  PokemonViewStore(this.service) : super(InitialPokemonViewState());

  Future fetchPokemon(String id) async {
    value = LoadingPokemonViewState();
    try {
      final pokemon = await service.fetchPokemon(id: id);
      value = SuccessPokemonViewState(pokemon);
    } catch (e) {
      value = ErrorPokemonViewState(e.toString());
    }
  }
}
