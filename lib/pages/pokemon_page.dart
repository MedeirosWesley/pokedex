import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/models/pokemonView_model.dart';
import 'package:pokedex/states/pokemonView_state.dart';
import 'package:pokedex/stores/pokemonview_store.dart';

import '../services/pokemonView_service.dart';

class PokemonPage extends StatefulWidget {
  Color color;
  String pokemonId;
  PokemonPage({Key? key, required this.color, required this.pokemonId})
      : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final store = PokemonViewStore(PokemonViewService());

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    store.fetchPokemon(widget.pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: store,
        builder: (BuildContext context, dynamic state, Widget? child) {
          if (state is LoadingPokemonViewState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorPokemonViewState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is SuccessPokemonViewState) {
            PokemonViewModel pokemon = state.pokemon;
            bool manytypes = pokemon.types.length > 1;
            return SafeArea(
              child: Container(
                color: Colors.white,
                height: size.height,
                child: Stack(
                  children: [
                    Positioned(
                        child: Container(
                            height: size.height * .5 + 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.white, widget.color],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                            child: Center(
                              child: Image.network(
                                pokemon.sprite,
                                height: (size.height * .5) * .8,
                              ),
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.arrow_back,
                          size: 40,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Positioned(
                        top: size.height * .47,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade900,
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(0, 3))
                            ],
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                          ),
                          height: size.height * .7,
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    pokemon.name,
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 28,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    pokemon.description,
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 16,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Peso: ${pokemon.weight}",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      Text(
                                        "Altura: ${pokemon.height}",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      "Abilidades",
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Normal: ${pokemon.abilities['normal'][0]}',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (pokemon.abilities['hidden'].length > 0)
                                        ? 'Especial: ${pokemon.abilities['hidden'][0]}'
                                        : 'Especial: -',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    manytypes
                        ? Positioned(
                            left: (size.width - (size.height * .08 + 10)) -
                                size.height * .08,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'assets/pokemons_types/${pokemon.types[1]}.png',
                                height: size.height * .08,
                              ),
                            ))
                        : Container(),
                    Positioned(
                        left: size.width - (size.height * .08 + 10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/pokemons_types/${pokemon.types[0]}.png',
                            height: size.height * .08,
                          ),
                        )),
                  ],
                ),
              ),
            );
          }
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
