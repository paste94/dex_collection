import 'dart:convert';

import 'package:dex_collection/config/config.dart';
import 'package:dex_collection/main.dart';
import 'package:http/http.dart' as http;

class PokeapiRepository {
  static Future<http.Response> getAllPokemonSpecies(int limit) async {
    final response = await http.get(
      // Uri.parse('https://pokeapi.co/api/v2/pokemon-form?limit=$limit'),
      Uri.parse('https://pokeapi.co/api/v2/pokemon-species?limit=$limit'),
    );
    // PokeapiRepository().fetchAllPokemonFormsWithGeneration();
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load Pokémon forms');
    }
  }

  static Future<http.Response> getUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load Pokémon from URL: $url');
    }
  }

  static Future<http.Response> getPokemonFormById(int id) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon-form/$id'),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load Pokémon form with ID: $id');
    }
  }

  // static Future<http.Response> getAllPokemons() =>
  //     http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=10000"));

  void fetchAllPokemonFormsWithGeneration() async {
    const baseUrl = 'https://pokeapi.co/api/v2/';
    const speciesEndpoint = '${baseUrl}pokemon-species?limit=$POKEMON_LIMIT';
    final response = await http.get(Uri.parse(speciesEndpoint));

    if (response.statusCode != 200) {
      throw Exception('Errore nel recuperare le specie Pokémon');
    }

    final speciesList = jsonDecode(response.body)['results'] as List;

    final List<Map<String, dynamic>> allForms = [];

    logger.i(
      '[PokeapiRepository] Fetching all Pokémon forms with generation: $allForms',
    );

    for (var species in speciesList) {
      final speciesDetailResponse = await http.get(Uri.parse(species['url']));
      if (speciesDetailResponse.statusCode != 200) continue;

      final speciesDetail = jsonDecode(speciesDetailResponse.body);
      final generation = speciesDetail['generation']['name'];

      // Otteniamo tutte le varietà (forme regionali e non)
      final varieties = speciesDetail['varieties'] as List;
      for (var variety in varieties) {
        final pokemonDataUrl = variety['pokemon']['url'];
        final pokemonResponse = await http.get(Uri.parse(pokemonDataUrl));
        if (pokemonResponse.statusCode != 200) continue;

        final pokemonData = jsonDecode(pokemonResponse.body);
        allForms.add({
          'name': pokemonData['name'],
          'id': pokemonData['id'],
          'is_default': variety['is_default'],
          'generation': generation,
        });
      }
    }
  }
}
