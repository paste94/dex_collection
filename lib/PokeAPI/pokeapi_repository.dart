import 'package:http/http.dart' as http;

class PokeapiRepository {
  static Future<http.Response> getAllPokemonForms(int limit) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon-form?limit=$limit'),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load Pokémon forms');
    }
  }

  static Future<http.Response> getPokemonForm(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load Pokémon form from URL: $url');
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
}
