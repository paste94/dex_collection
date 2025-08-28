import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:hive_ce/hive.dart';

class CollectionRepo {
  late Box<Collection> _box;
  late List<Collection> _collections;

  // GET
  List<Collection> getCollections() {
    _box = Hive.box(COLLECTION_BOX);
    _collections = _box.values.toList();
    return _collections;
  }

  // CREATE, UPDATE
  List<Collection> putCollection(Collection collection) {
    _box.put(collection.id, collection);
    return _box.values.toList();
  }

  // DELETE
  List<Collection> removeCollection(Collection collection) {
    _box.deleteAt(
      _box.values.toList().indexWhere((element) => element.id == collection.id),
    );
    return _box.values.toList();
  }

  // DELETE ALL
  Future<void> clearCollection() async {
    await _box.clear();
  }
}
