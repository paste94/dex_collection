import 'package:dex_collection/Hive/pokemon/pokemon_repo.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_pokemon_provider.g.dart';

@riverpod
class DbPokemon extends _$DbPokemon {
  late PokemonRepo repo;

  @override
  List<Pokemon> build() {
    repo = PokemonRepo();
    return repo.getPokemons();
  }

  void fetchPokemon() {
    state = repo.getPokemons();
  }

  void addAllPokemons(List<Pokemon> pokemons) {
    repo.addAllPokemons(pokemons);
    state = repo.getPokemons();
  }

  void clearCollection() async {
    await repo.clearCollection();
    state = repo.getPokemons();
  }
}
