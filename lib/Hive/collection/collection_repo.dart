import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:hive/hive.dart';

class CollectionRepo {
  late Box<Collection> _box;
  late List<Collection> _collections;

  List<Collection> getCollections() {
    _box = Hive.box(COLLECTION_BOX);
    _collections = _box.values.toList();
    return _collections;
  }

  List<Collection> putCollection(Collection collection) {
    _box.put(collection.id, collection);
    logger.i(
      '[collection_repo.dart - addCollection] Added, returning ${_box.values.toList()}',
    );
    return _box.values.toList();
  }

  List<Collection> removeCollection(String id) {
    _box.deleteAt(
      _box.values.toList().indexWhere((element) => element.id == id),
    );
    return _box.values.toList();
  }

  void hideColletionById(String id) {
    logger.i(
      '[collection_repo.dart - hideColletionById] Hiding collection with id: $id',
    );
    Collection? item = _box.get(id);
    if (item != null) {
      item.isHidden = true;
      item.save();
      logger.i(
        '[collection_repo.dart - hideColletionById] Collection hidden: $item',
      );
    } else {
      logger.w(
        '[collection_repo.dart - hideColletionById] No collection found with id: $id',
      );
    }
  }

  Future<void> clearCollection() async {
    await _box.clear();
  }

  List<Collection> toggleCaptured(int collectionIndex, int pokemonId) {
    final collection = _box.getAt(collectionIndex);

    if (collection != null) {
      final collected =
          collection.pokemons?.where((p) => p.id == pokemonId).first;
      if (collected == null) {
        logger.w(
          '[collection_repo.dart - toggleCaptured] No collected Pokemon found with id: $pokemonId',
        );
      } else {
        collected.isCaptured = !collected.isCaptured;
        collection.save();
        logger.i(
          '[collection_repo.dart - toggleCaptured] Toggled captured state for Pokemon with id: $pokemonId',
        );
      }
    }
    return _box.values.toList();
  }
}
