import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/models/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PokemonService {
  static Future<void> savePokemons(List<Pokemon> pokemonList) async {
    logger.i('saving ${pokemonList[0]}');
    final pokemonBox = Hive.box(POKEMON_BOX);
    await pokemonBox.put(POKEMON_KEY, pokemonList);
  }
}
