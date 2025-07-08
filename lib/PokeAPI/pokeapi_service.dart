import 'dart:convert';
import 'package:dex_collection/PokeAPI/pokeapi_repository.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';

class PokeapiService {
  static Future<List<Pokemon>> getAllPokemons({
    Function(double progress)? progressCalback,
  }) async {
    final response = await PokeapiRepository.getAllPokemonForms(50);
    final data = json.decode(response.body);
    List result = data['results'];
    List<Pokemon> pokemonList = [];
    for (final elem in result) {
      // logger.i('Fetching form: $elem');
      Pokemon pokemon = await getPokemonForm(elem['url']);
      pokemonList.add(pokemon);
      if (progressCalback != null) {
        progressCalback(pokemonList.length / result.length);
      }
    }
    return pokemonList;
  }

  static Future<Pokemon> getPokemonForm(String url) async {
    final response = await PokeapiRepository.getPokemonForm(url);
    final data = json.decode(response.body);

    return Pokemon.fromJson(data);
  }
}
