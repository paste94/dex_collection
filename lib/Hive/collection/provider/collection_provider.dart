import 'package:dex_collection/Hive/collection/collection_repo.dart';
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

  void clearCollection() async {
    await repo.clearCollection();
    state = repo.getCollections();
  }

  Future<void> addOrUpdateCollection(Collection collection) async {
    state = repo.putCollection(collection);
  }

  void hideCollectionById(String id) {
    state = repo.putCollection(
      state.firstWhere((element) => element.id == id).copyWith(isHidden: true),
    );
  }

  void unhideCollectionById(String id) {
    state = repo.putCollection(
      state.firstWhere((element) => element.id == id).copyWith(isHidden: false),
    );
  }

  void deleteHiddenCollections() {
    state
        .where((element) => element.isHidden == true)
        .forEach((element) => repo.removeCollection(element.id));
    state = repo.getCollections();
  }
}
