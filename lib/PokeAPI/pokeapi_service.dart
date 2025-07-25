import 'dart:convert';
import 'package:dex_collection/PokeAPI/pokeapi_repository.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/config/config.dart';
// ignore: unused_import
import 'package:dex_collection/main.dart';

class PokeapiService {
  static Future<List<Pokemon>> getAllPokemons({
    Function(double progress)? progressCalback,
  }) async {
    final response = await PokeapiRepository.getAllPokemonSpecies(
      POKEMON_LIMIT,
    );
    final species = json.decode(response.body);
    List result = species['results'];
    List<Pokemon> pokemonList = [];

    for (var i = 0; i < result.length; i++) {
      List<Pokemon> pokemons = await getPokemonsFromSpecie(result[i]['url']);
      pokemonList.addAll(pokemons);
      if (progressCalback != null) {
        progressCalback(i / result.length);
      }
    }

    return pokemonList;
  }

  static Future<List<Pokemon>> getPokemonsFromSpecie(String url) async {
    final List<Pokemon> pokemonList = [];
    final specieResponse = await PokeapiRepository.getUrl(url);
    final pokemonSpecie = json.decode(specieResponse.body);

    final varietiesList = pokemonSpecie['varieties'] as List;

    for (final variety in varietiesList) {
      final pokemonResponse = await PokeapiRepository.getUrl(
        variety['pokemon']['url'],
      );
      final pokemon = json.decode(pokemonResponse.body);

      pokemonList.add(
        Pokemon(
          id: pokemon['id'],
          name: pokemon['name'],
          img: pokemon['sprites']['front_default'],
          generation: pokemonSpecie['generation']['name'],
        ),
      );
    }

    return pokemonList;
  }

  static Future<Pokemon> getPokemonForm(String url) async {
    final response = await PokeapiRepository.getUrl(url);
    final data = json.decode(response.body);
    logger.i('Fetched form: $data');

    return Pokemon.fromJson(data);
  }
}
