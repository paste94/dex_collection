import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/collection_repo.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/main.dart';
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

  Collection _getCollectionById(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  Collection getSelectedCollection() {
    String? id = ref.watch(collectionIdProvider);
    if (id != null) {
      return _getCollectionById(id);
    } else {
      return Collection(name: '');
    }
  }

  List<CollectedPokemon> getSelectedCollectionPokemons() {
    return getSelectedCollection().pokemons?.map((e) {
          e.pokemon = ref
              .watch(dbPokemonProvider)
              .firstWhere((pokemon) => pokemon.id == e.id);
          return e;
        }).toList() ??
        [];
  }

  void clearCollection() async {
    await repo.clearCollection();
    state = repo.getCollections();
  }

  Future<void> addOrUpdateCollection(Collection collection) async {
    state = repo.putCollection(collection);
  }

  void hideCollectionById(String id) {
    final collection = _getCollectionById(id);
    addOrUpdateCollection(collection.copyWith(isHidden: true));
  }

  void unhideCollectionById(String id) {
    final collection = _getCollectionById(id);
    addOrUpdateCollection(collection.copyWith(isHidden: false));
  }

  void deleteHiddenCollections() {
    state
        .where((element) => element.isHidden == true)
        .forEach((element) => repo.removeCollection(element));
    state = repo.getCollections();
  }

  void toggleCaptured(String collectionId, int pokemonId) {
    Collection collection = _getCollectionById(collectionId);
    CollectedPokemon? pokemon = collection.pokemons
        ?.where((p) => p.id == pokemonId)
        .first;

    if (pokemon == null) {
      logger.w(
        '[collection_provider.dart - toggleCaptured] No collected Pokemon found in collection [${collection.id}] with id [$pokemonId]',
      );
      return;
    }
    pokemon.isCaptured = !pokemon.isCaptured;
    addOrUpdateCollection(collection);
  }

  void toggleShiny(String collectionId, int pokemonId) {
    Collection collection = _getCollectionById(collectionId);
    CollectedPokemon? pokemon = collection.pokemons
        ?.where((p) => p.id == pokemonId)
        .first;

    if (pokemon == null) {
      logger.w(
        '[collection_provider.dart - toggleShiny] No collected Pokemon found in collection [${collection.id}] with id [$pokemonId]',
      );
      return;
    }
    pokemon.isShiny = !(pokemon.isShiny ?? false);
    addOrUpdateCollection(collection);
  }

  void updateOrder(Map<String, int> idIndex) {
    /// idIndex contains a map <CollectionID - newIndex>
    idIndex.forEach((collectionId, newOrder) {
      Collection collection = _getCollectionById(collectionId);
      if (collection.order != newOrder) {
        repo.putCollection(collection.copyWith(order: newOrder));
      }
    });
    state = repo.getCollections();
  }
}
