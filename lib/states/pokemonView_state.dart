import '../models/pokemonView_model.dart';

abstract class PokemonViewState {}

class InitialPokemonViewState extends PokemonViewState {}

class SuccessPokemonViewState extends PokemonViewState {
  final PokemonViewModel pokemon;
  SuccessPokemonViewState(this.pokemon);
}

class LoadingPokemonViewState extends PokemonViewState {}

class ErrorPokemonViewState extends PokemonViewState {
  final String message;

  ErrorPokemonViewState(this.message);
}
