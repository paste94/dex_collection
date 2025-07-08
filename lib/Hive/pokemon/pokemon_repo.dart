import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PokemonRepo {
  late Box<Pokemon> _box;
  late List<Pokemon> _pokemons;

  List<Pokemon> getPokemons() {
    _box = Hive.box(POKEMON_BOX);
    _pokemons = _box.values.toList();
    return _pokemons;
  }

  void addAllPokemons(List<Pokemon> pokemonList) {
    _box = Hive.box(POKEMON_BOX);
    for (var pokemon in pokemonList) {
      if (!_box.values.any((element) => element.id == pokemon.id)) {
        _box.add(pokemon);
      }
    }
  }

  Future<void> clearCollection() async {
    await _box.clear();
  }
}
