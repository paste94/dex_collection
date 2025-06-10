import 'package:http/http.dart' as http;

class PokeapiRepository {
  static Future<http.Response> getAllPokemons() =>
      http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=10000"));
}
