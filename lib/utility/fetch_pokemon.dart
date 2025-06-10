import 'package:dex_collection/Hive/pokemon_service.dart';
import 'package:dex_collection/PokeAPI/pokeapi_service.dart';
import 'package:dex_collection/main.dart';

Future<void> fetchPokemon() async {
  final pokemonList = await PokeapiService.getAllPokemons();
  logger.i('message');
  PokemonService.savePokemons(pokemonList);
}
