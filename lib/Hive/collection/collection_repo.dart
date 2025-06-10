import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/models/collection.dart';
import 'package:hive/hive.dart';

class CollectionRepo {
  late Box<Collection> _box;
  late List<Collection> _collections;

  List<Collection> getCollections() {
    // Hive.openBox(COLLECTION_BOX);
    _box = Hive.box(COLLECTION_BOX);
    _collections = _box.values.toList();
    return _collections;
  }

  List<Collection> addCollection(Collection collection) {
    logger.i('[collection_repo.dart - addCollection] Adding ${collection}');
    _box.add(collection);
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

  List<Collection> updateCollection(int index, Collection todo) {
    _box.putAt(index, todo);
    return _box.values.toList();
  }
}
