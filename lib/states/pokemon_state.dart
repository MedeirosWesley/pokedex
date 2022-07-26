import '../models/pokemon_model.dart';

abstract class PokemonState {}

class InitialPokemonState extends PokemonState {}

class SuccessPokemonState extends PokemonState {
  final List<PokemonModel> pokemons;

  SuccessPokemonState(this.pokemons);
}

class LoadingPokemonState extends PokemonState {}

class ErrorPokemonState extends PokemonState {
  final String message;

  ErrorPokemonState(this.message);
}
