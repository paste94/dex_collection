import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
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

  List<Collection> addCollection(Collection collection) {
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

  Future<void> clearCollection() async {
    await _box.clear();
  }

  Future<void> updateCollection({
    required id,
    String? name,
    int? color,
    List<PokemonCollection>? pokemons,
  }) async {
    logger.i(
      '[collection_repo.dart - updateCollection] Updating collection with id: $id',
    );
    _box = Hive.box(COLLECTION_BOX);
    Collection? item = _box.get(id);

    if (item == null) {
      logger.w(
        '[collection_repo.dart - updateCollection] No collection found with id: $id',
      );
      return;
    }
    logger.i(
      '[collection_repo.dart - updateCollection] Found collection: $item',
    );
    item.name = name ?? item.name;
    item.color = color ?? item.color;
    item.pokemons = pokemons ?? item.pokemons;

    await item.save();

    logger.i('''[collection_repo.dart - updateCollection] Updated collection: {
        id: ${item.id},
        name: ${item.name},
        color: ${item.color},
        pokemons: ${item.pokemons?.map((e) => e.id).toList()},
      }''');
  }
}
