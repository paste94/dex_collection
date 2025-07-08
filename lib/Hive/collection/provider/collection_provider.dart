import 'package:dex_collection/Hive/collection/collection_repo.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_provider.g.dart';

@riverpod
class CollectionState extends _$CollectionState {
  late CollectionRepo repo;

  @override
  List<Collection> build() {
    repo = CollectionRepo();
    return repo.getCollections();
  }

  void fetchCollection() {
    state = repo.getCollections();
  }

  void addCollection(Collection collection) {
    logger.i('[collection_provider.dart - addCollection] Adding ${collection}');
    state = repo.addCollection(collection);
  }

  void removeCollection(String id) {
    state = repo.removeCollection(id);
  }

  void clearCollection() async {
    await repo.clearCollection();
    state = repo.getCollections();
  }

  Future<void> addPokemonListToCollection(
    String collectionId,
    List<Pokemon> pokemonList,
  ) async {
    logger.i(
      '[collection_provider.dart - addPokemonListToCollection] Adding ${pokemonList.length} pokemons to collection $collectionId',
    );
    await repo.updateCollection(
      id: collectionId,
      pokemons:
          pokemonList.map((item) => PokemonCollection(id: item.id)).toList(),
    );
    fetchCollection();
  }
}
