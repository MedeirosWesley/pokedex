import 'package:flutter/material.dart';
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

  final store = PokemonStore(PokemonService());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                  //     child: Image.asset(
                  //   'assets/Pokebola.jpg',
                  //   height: size.height * .3,
                  // )),
                  child: Container(height: size.height * .3)),
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
                        return Image.network(pokemon.sprite);
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
