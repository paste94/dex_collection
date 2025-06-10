import 'package:dex_collection/Hive/collection/collection_repo.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/models/collection.dart';
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

  void updateCollection(int index, Collection newCollection) {
    state = repo.updateCollection(index, newCollection);
  }
}
