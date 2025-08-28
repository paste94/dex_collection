// import 'package:dex_collection/Hive/collection/model/collection.dart';
// import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
// import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final selectedCollectionProvider = StateProvider.autoDispose<Collection>((ref) {
//   final collectionId = ref.watch(collectionIdProvider);
//   return collectionId == null
//       ? Collection(name: '')
//       : ref
//             .read(collectionStateProvider)
//             .where((element) => element.id == collectionId)
//             .first;
// });
