import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = StateProvider<int?>((ref) {
  return null;
});

// class IndexNotifier extends StateNotifier<int?> {
//   IndexNotifier() : super(null);

//   void setIndex(int index) => state = index;
//   void clear() => state = null;
// }

// final indexProvider = StateNotifierProvider.autoDispose<IndexNotifier, int?>((
//   ref,
// ) {
//   final notifier = IndexNotifier();

//   ref.onDispose(() {
//     logger.i('[index_provider.dart] Disposing IndexNotifier');
//     // Questo verrà eseguito automaticamente quando il widget che usa il provider viene distrutto
//     notifier.clear(); // oppure: notifier.state = null;
//   });

//   return notifier;
// });
