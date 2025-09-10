import 'package:dex_collection/Hive/collection/collection_repo.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_provider.g.dart';

@riverpod
class CollectionList extends _$CollectionList {
  late CollectionRepo repo;

  @override
  List<Collection> build() {
    repo = CollectionRepo();
    return repo.getCollections();
  }

  Collection _getCollectionById(String id) {
    return state.firstWhere((element) => element.id == id);
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

    final updatedPokemons = collection.pokemons?.map((p) {
      if (p.id == pokemonId) {
        return p.copyWith(isCaptured: !p.isCaptured);
      }
      return p;
    }).toList();
    addOrUpdateCollection(collection.copyWith(pokemons: updatedPokemons));
  }

  void toggleShiny(String collectionId, int pokemonId) {
    Collection collection = _getCollectionById(collectionId);

    final updatedPokemons = collection.pokemons?.map((p) {
      if (p.id == pokemonId) {
        return p.copyWith(isShiny: !(p.isShiny ?? false));
      }
      return p;
    }).toList();

    addOrUpdateCollection(collection.copyWith(pokemons: updatedPokemons));
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

final collectionItemProvider = Provider.family<Collection, String?>((ref, id) {
  return ref
      .watch(collectionListProvider)
      .firstWhere(
        (element) => element.id == id,
        orElse: () => Collection(name: ''),
      );
});
