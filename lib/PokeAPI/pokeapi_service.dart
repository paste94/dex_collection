import 'dart:convert';

import 'package:dex_collection/PokeAPI/pokeapi_repository.dart';
import 'package:dex_collection/models/pokemon.dart';

class PokeapiService {
  static Future<List<Pokemon>> getAllPokemons() async {
    final response = await PokeapiRepository.getAllPokemons();
    List<Map<String, dynamic>> data = List.from(
      json.decode(response.body)['results'],
    );
    List<Pokemon> pokemonList =
        data.asMap().entries.map<Pokemon>((element) {
          element.value['id'] = element.key + 1;
          element.value['img'] =
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
          return Pokemon.fromJson(element.value);
        }).toList();
    return pokemonList;
  }
}
