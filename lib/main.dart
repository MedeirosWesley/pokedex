import 'package:flutter/material.dart';
import 'package:pokedex/colors_types.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:pokedex/states/pokemon_state.dart';
import 'package:pokedex/stores/pokemon_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    store.fetchPokemons();
  }

  var colorType = ColorType();
  final store = PokemonStore(PokemonService());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heigthContainer = size.height * .2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                  child: Container(
                color: Colors.transparent,
                height: heigthContainer + 60,
              )),
              Positioned(
                  child: Container(
                      height: heigthContainer, color: const Color(0xFFFE0000))),
              Positioned(
                  top: heigthContainer,
                  child: Container(
                    height: 30,
                    width: size.width,
                    color: Colors.black,
                  )),
              Positioned(
                top: heigthContainer / 2 - 50,
                right: size.width / 2 - 89,
                child: Image.asset(
                  'assets/Pokemon-Logo.png',
                  height: 100,
                ),
              ),
              Positioned(
                  top: heigthContainer - 25,
                  left: size.width / 2 - 40,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50)),
                  )),
              Positioned(
                  top: heigthContainer - 10,
                  left: size.width / 2 - 25,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                  )),
            ],
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: store,
              builder: (_, state, child) {
                if (state is LoadingPokemonState) {
                  return Center(
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Buscando Dados",
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
                if (state is ErrorPokemonState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is SuccessPokemonState) {
                  return GridView.builder(
                      itemCount: state.pokemons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (_, index) {
                        final pokemon = state.pokemons[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            constraints:
                                BoxConstraints(maxWidth: (size.width - 50) / 3),
                            decoration: BoxDecoration(
                                color: colorType.selectColor(pokemon.types[0]),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500]!,
                                    offset: const Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-4, -4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: Column(
                              children: [
                                Image.network(
                                  pokemon.sprite,
                                  width: (size.width - 40) / 3 - 45,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    pokemon.name,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
