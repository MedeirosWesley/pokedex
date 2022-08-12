import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/pokemonView_service.dart';

class PokemonPage extends StatefulWidget {
  PokemonPage({Key? key, required color, required pokemon}) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  void initState() {
    super.initState();
  }

  teste() async {
    var pokemonservice = PokemonViewService();
    var pokemon = await pokemonservice.fetchPokemon(id: '1');
  }

  @override
  Widget build(BuildContext context) {
    teste();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
                child: Container(
                    height: size.height * .5 + 40,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.white, Colors.orange],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                      child: Image.network(
                        'https://cdn.traction.one/pokedex/pokemon/6.png',
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
                onTap: () {},
              ),
            ),
            Positioned(
                top: size.height * .45,
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
                        const Center(
                          child: Text(
                            "Pokemon",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Peso: 100KG",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                "Altura: 2M",
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
                            'Normal: Abilidade normal',
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
                            'Especial: Abilidade especial',
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
            Positioned(
                left:
                    (size.width - (size.height * .08 + 10)) - size.height * .08,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/pokemons_types/Dragon.png',
                    height: size.height * .08,
                  ),
                )),
            Positioned(
                left: size.width - (size.height * .08 + 10),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/pokemons_types/Fire.png',
                    height: size.height * .08,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
