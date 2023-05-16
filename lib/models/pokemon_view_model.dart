import 'dart:convert';

class PokemonViewModel {
  final String id;
  final String name;
  final List types;
  final Map abilities;
  final String height;
  final String weight;
  final String sprite;
  final String description;

  PokemonViewModel({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.sprite,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'types': types,
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'sprite': sprite,
      'description': description,
    };
  }

  factory PokemonViewModel.fromMap(Map<String, dynamic> map) {
    return PokemonViewModel(
      id: map['id'] as String,
      name: map['name'] as String,
      types: List.from((map['types'] as List)),
      abilities: Map.from((map['abilities'] as Map)),
      height: map['height'] as String,
      weight: map['weight'] as String,
      sprite: map['sprite'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonViewModel.fromJson(String source) =>
      PokemonViewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
