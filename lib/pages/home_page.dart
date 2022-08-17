import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/pages/pokemon_page.dart';

import '../colors_types.dart';
import '../services/pokemon_service.dart';
import '../states/pokemon_state.dart';
import '../stores/pokemon_store.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var colorType = ColorType();
  final store = PokemonStore(PokemonService());

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    store.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heigthContainer = size.height * .2;
    final imageWidth = size.width / 3 - 25;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                  height: heigthContainer,
                  color: const Color(0xFFFE0000),
                  child: Center(
                    child: Image.asset(
                      'assets/Pokemon-Logo.png',
                      width: size.width / 2,
                    ),
                  ),
                )),
                Positioned(
                    top: heigthContainer,
                    child: Container(
                      height: 30,
                      width: size.width,
                      color: Colors.black,
                    )),
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
            ValueListenableBuilder(
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
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.pokemons.length,
                      itemBuilder: (_, index) {
                        final pokemon = state.pokemons[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 130,
                            constraints:
                                BoxConstraints(maxWidth: (size.width - 50)),
                            decoration: BoxDecoration(
                                color: (colorType.selectColor(pokemon.types[0]))
                                    .withOpacity(.6),
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
                            child: GestureDetector(
                              onTap: (() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => PokemonPage(
                                          pokemonId: pokemon.id,
                                          color: colorType
                                              .selectColor(pokemon.types[0]),
                                        ))));
                              }),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 130 / 2 - 120,
                                    child: Text(
                                      '#${pokemon.id}',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.rubikMicrobe(
                                          color: Colors.white.withOpacity(.4),
                                          fontSize: 130,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    bottom: 130 / 2 - 45,
                                    child: Text(
                                      pokemon.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.rubikMonoOne(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Positioned(
                                    top: (130 / 2) - (imageWidth / 2) - 10,
                                    left: size.width - (imageWidth + 30),
                                    child: CachedNetworkImage(
                                      imageUrl: pokemon.sprite,
                                      width: imageWidth,
                                      height: imageWidth,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: Colors.white,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset('assets/Pokebola.png',
                                              width: imageWidth),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Container();
              },
            ),
          ],
        ),
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
